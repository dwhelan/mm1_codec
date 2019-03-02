defmodule Codec.Map do
  import OkError
  import OkError.Operators
  import CodecError
  use MMS.Codec2

  # TODO Remove once Lookup is dead
  def get(value, map), do: Map.get map, value

  def with_index list do
    list
    |> Enum.with_index
    |> Enum.reduce(
         %{},
         fn {v, i}, map ->
           map
           |> Map.put(i, v)
         end
       )
  end

  def invert map do
    map
    |> Enum.reduce(
         %{},
         fn {k, v}, inverse ->
           inverse
           |> Map.put(v, k)
         end
       )
  end

  defmacro decode bytes, codec, mapper do
    quote bind_quoted: [bytes: bytes, mapper: mapper, codec: codec, module: __CALLER__.module] do
      bytes
      |> codec.decode
      ~> fn result -> result |> map_decoded_value(mapper) end
      ~>> fn details -> error data_type(module), bytes, nest_error(details) end
    end
  end

  def map_decoded_value({value, rest}, f) when is_function(f) do
    case f.(value) do
      {:ok, result}       -> decode_ok result, rest
      error = {:error, _} -> error
      result              -> decode_ok result, rest
    end
  end

  def map_decoded_value({value, rest}, map) when is_map(map) do
    result = Map.get(map, value)

    cond do
      is_nil(result)     -> error %{out_of_range: value}
      is_module?(result) -> rest |> result.decode
      true               -> decode_ok result, rest
    end
  end

  defp is_module?(atom) when is_atom(atom), do: atom |> to_string |> String.starts_with?("Elixir.")
  defp is_module?(_),                       do: false

  defmacro encode(value, f = {atom, _, _}, codec) when atom in [:fn, :&] do
    do_encode f, value, codec, __CALLER__
  end

  defmacro encode(value, map_codec, map)  do
    map
    |> invert(__CALLER__)
    |> encode_get
    |> do_encode(value, map_codec, __CALLER__)
  end

  defmacro encode(value, map_codec, map, codec)  do
    map_codec = Macro.expand(map_codec, __CALLER__)
    codec = Macro.expand(codec, __CALLER__)
    map = invert(map, __CALLER__)

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

  defp encode_get map do
    quote do
      fn value ->
        Map.get(unquote(map), value)
        ~>> fn nil   -> error :out_of_range end
        ~>  fn value -> ok value end
      end
    end
  end

  defp do_encode(f, value, map_codec, caller) do
    quote bind_quoted: [value: value, f: f, map_codec: map_codec, module: caller.module] do
      f.(value)
      ~> fn mapped_value -> mapped_value |> map_codec.encode end
      ~>> fn details -> error data_type(module), value, nest_error(details) end
    end
  end

  defp invert map, env do
    {:%{}, context, pairs} = Macro.expand(map, env)
    {:%{}, context, pairs |> Enum.map(fn {k, v} -> {v, k} end)}
  end
end
