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

  def map_decoded_value(value, map) when is_map(map) do
    case Map.get(map, value) do
      nil -> error %{out_of_range: value}
      result -> ok result
    end
  end

  def map_decoded_value(value, f) when is_function(f) do
    f.(value)
  end

  defmacro map_encode(value, map = {atom, _, _}, codec) when atom in [:fn, :&] do
    do_map_encode value, map, codec, __CALLER__.module
  end

  defmacro map_encode(value, map, codec)  do
    inverted_map =
      map
      |> Macro.expand(__CALLER__)
      |> invert_map_ast

    f = quote do
      fn value ->
        case Map.get(unquote(inverted_map), value) do
          nil -> error :out_of_range
          result -> ok result
        end
      end
    end

    do_map_encode value, f, codec, __CALLER__.module
  end

  defp invert_map_ast {:%{}, context, pairs} do
    {:%{}, context, pairs |> Enum.map(fn {k, v} -> {v, k} end)}
  end

  defp do_map_encode(value, f, codec, module) do
    data_type = data_type(module)
    quote do
      unquote(value)
      |> unquote(f).()
      ~> fn result -> unquote(codec).encode(result)end
      ~>> fn details -> error unquote(data_type), unquote(value), nest_decode_error(details) end
    end
  end
end
