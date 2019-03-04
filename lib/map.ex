defmodule Codec.Map do
  import OkError
  import OkError.Operators
  import CodecError
  use MMS.Codec2

  defmacro decode bytes, codec, mapper do
    mapper
    |> Macro.expand(__CALLER__)
    |> to_decode_mapper
    |> do_decode(bytes, codec, __CALLER__)
  end

  defp to_decode_mapper(f = {atom, _, _}) when atom in [:fn, :&] do
    f
  end

  defp to_decode_mapper(map = {:%{}, _, _}) do
    map
    |> decode_get
  end

  defp to_decode_mapper(list) when is_list(list) do
    list
    |> to_map
    |> invert
    |> decode_get
  end

  defp decode_get map do
    quote do
      fn value ->
        Map.get(unquote(map), value)
        ~>> fn nil   -> error %{out_of_range: value} end
        ~>  fn value -> ok value end
      end
    end
  end

  defp do_decode f, bytes, codec, caller do
    quote bind_quoted: [f: f, bytes: bytes, codec: codec, module: caller.module] do
      bytes
      |> codec.decode
      ~> fn {value, rest} ->
            value
            |> f.()
            ~> fn result ->
                 if is_module?(result) do
                   rest |> result.decode
                 else
                   result |> decode_ok(rest)
                 end
               end
         end
      ~>> fn details -> error data_type(module), bytes, nest_error(details) end
    end
  end

  def is_module?(atom) when is_atom(atom), do: atom |> to_string |> String.starts_with?("Elixir.")
  def is_module?(_),                       do: false

  defmacro encode(value, codec, mapper)  do
    mapper
    |> Macro.expand(__CALLER__)
    |> to_encode_mapper
    |> do_encode(value, codec, __CALLER__)
  end

  defp to_encode_mapper(f = {atom, _, _}) when atom in [:fn, :&] do
    f
  end

  defp to_encode_mapper(map = {:%{}, _, _}) do
    map
    |> invert
    |> encode_get
  end

  defp to_encode_mapper(list) when is_list(list) do
    list
    |> to_map
    |> encode_get
  end

  defp encode_get map do
    quote do
      fn value ->
        Map.get(unquote(map), value)
        ~>> fn nil   -> error :out_of_range end
        ~>  fn value -> ok value end
      end
    end
  end

  defmacro encode(value, map_codec, map, codec)  do
    map_codec = Macro.expand(map_codec, __CALLER__)
    codec = Macro.expand(codec, __CALLER__)
    map = map |> Macro.expand(__CALLER__) |> invert

    quote bind_quoted: [value: value, map: map, codec: codec, map_codec: map_codec, module: __CALLER__.module] do
      Map.get(map, value)
      ~> fn map_value ->
           map_value
           |> map_codec.encode
         end
      ~>> fn _ ->
            Map.get(map, codec)
            ~> fn map_value ->
                 map_value
                 |> map_codec.encode
                 ~> fn map_bytes ->
                      value
                      |> codec.encode
                      ~> fn value_bytes -> map_bytes <> value_bytes end
                     end
               end
          end
      ~>> fn details -> error data_type(module), value, nest_error(details) end
    end
  end

  defp do_encode(f, value, map_codec, caller) do
    quote bind_quoted: [value: value, f: f, map_codec: map_codec, module: caller.module] do
      value
      |> f.()
      ~>  fn map_value -> map_value |> map_codec.encode end
      ~>> fn details   -> error data_type(module), value, nest_error(details) end
    end
  end

  defp invert {:%{}, context, kv_pairs} do
    {:%{}, context, kv_pairs |> Enum.map(fn {k, v} -> {v, k} end)}
  end

  defp to_map list do
    {:%{}, [], Enum.with_index(list)}
  end
end
