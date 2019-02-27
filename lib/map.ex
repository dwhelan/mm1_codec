defmodule Codec.Map do
  import OkError
  import OkError.Operators
  import CodecError
  use MMS.Codec2

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

  defmacro decode_map bytes, codec, mapper do
    data_type = data_type(__CALLER__.module)
    quote location: :keep do
      unquote(bytes)
      |> unquote(codec).decode
      ~> fn result -> result |> map_decoded_value(unquote mapper) end
      ~>> fn details -> error unquote(data_type), unquote(bytes), nest_error(details) end
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

  defp is_module?(atom) when is_atom(atom) do
    atom
    |> to_string
    |> String.starts_with?("Elixir.")
  end

  defp is_module? other do
    false
  end

  defmacro map_encode(value, f = {atom, _, _}, codec) when atom in [:fn, :&] do
    data_type = data_type(__CALLER__.module)

    quote do
      unquote(f).(unquote(value))
      ~> fn mapped_value -> unquote(codec).encode(mapped_value) end
      ~>> fn details -> error unquote(data_type), unquote(value), nest_error(details) end
    end
  end

  defmacro map_encode(value, {map, codec}, map_codec)  do
    map = invert_map(map, __CALLER__)
    codec = Macro.expand(codec, __CALLER__)

    quote bind_quoted: [value: value, map: map, codec: codec, map_codec: map_codec, module: __CALLER__.module] do
      case Map.get(map, value) do
        nil -> Map.get(map, codec)
               ~> fn map_value ->
                    map_value
                    |> map_codec.encode
                    ~> fn map_bytes ->
                        value
                        |> codec.encode
                        ~> fn value_bytes -> map_bytes <> value_bytes end
                       end
                  end
        map_value -> map_value |> map_codec.encode
      end
      ~>> fn details -> error data_type(module), value, nest_error(details) end
    end
  end

  def map_value_to_encode(value, inverted_map) when is_map(inverted_map) do
    case Map.get(inverted_map, value) do
      nil -> error :out_of_range
      value_to_encode -> value_to_encode
    end
  end

  defmacro map_encode(value, map, codec)  do
    inverted_map = invert_map(map, __CALLER__)
    do_map_encode value, inverted_map, codec, __CALLER__

    data_type = data_type(__CALLER__.module)

    quote do
      Map.get(unquote(map), unquote(value))
      ~> unquote(codec).encode(&1)
      ~>> fn details -> error unquote(data_type), unquote(value), nest_error(details) end
    end

    do_map_encode value, inverted_map, codec, __CALLER__
  end

  defp invert_map map, env do
    {:%{}, context, pairs} = Macro.expand(map, env)
    {:%{}, context, pairs |> Enum.map(fn {k, v} -> {v, k} end)}
  end

  defp do_map_encode(value, mapper, codec, env) do
    data_type = data_type(env.module)

    quote do
      unquote(value)
      |> map_value_to_encode(unquote mapper)
      ~> fn mapped_value -> unquote(codec).encode(mapped_value) end
      ~>> fn details -> error unquote(data_type), unquote(value), nest_error(details) end
    end
  end

  def map_value_to_encode(value, {inverted_map, bar}) when is_map(inverted_map) do
    IO.inspect  {inverted_map, bar, Map.get(inverted_map, value), value |> bar.encode}
    case Map.get(inverted_map, value) do
      nil -> Map.get(inverted_map, bar)
      value_to_encode -> value_to_encode
    end
  end

  defp encode_with_prefix value, codec, prefix do
    value
    |> codec.encode
    ~> fn bytes -> <<prefix>> <> bytes end
  end

  def map_value_to_encode(value, inverted_map) when is_map(inverted_map) do
    case Map.get(inverted_map, value) do
      nil -> error :out_of_range
      value_to_encode -> value_to_encode
    end
  end

  def map_value_to_encode(value, f) when is_function(f) do
    f.(value)
  end
end
