defmodule Codec.Map do
  import OkError
  import CodecError
  import MMS.Codec2

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

  def map_decoded_value(value, map) when is_map(map) do
    case Map.get(map, value) do
      nil -> error %{out_of_range: value}
      result -> ok result
    end
  end

  def map_decoded_value(value, f) when is_function(f) do
    f.(value)
  end

  def map value, map do
    case Map.get(map, value) do
      nil -> error :out_of_range
      result -> ok result
    end
  end

  defmacro decode_map bytes, codec, map do
    data_type = data_type(__CALLER__.module)
    quote location: :keep do
      unquote(bytes)
      |> unquote(codec).decode
      ~> fn {value, rest} ->
        value
        |> map_decoded_value(unquote map)
        ~> fn result -> ok result, rest end
         end
      ~>> fn details -> error unquote(data_type), unquote(bytes), nest_decode_error(details) end
    end
  end

  defmacro map_encode value, map, codec do
    data_type = data_type(__CALLER__.module)
    quote do
      unquote(value)
      |> map(invert unquote(map))
      ~> fn result -> unquote(codec).encode(result)end
      ~>> fn details -> error unquote(data_type), unquote(value), nest_decode_error(details) end
    end
  end
end
