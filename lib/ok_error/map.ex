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

  defmacro map_encode(value, map = {atom, _, _}, codec) when atom in [:fn, :&] do
    do_map_encode value, map, codec, __CALLER__.module
  end

  defmacro map_encode(value, map, codec)  do
    inverted_map =
      map
      |> Macro.expand(__CALLER__)
      |> invert_map

    do_map_encode value, inverted_map, codec, __CALLER__.module
  end

  defp invert_map {:%{}, context, pairs} do
    {:%{}, context, pairs |> Enum.map(fn {k, v} -> {v, k} end)}
  end

  defp do_map_encode(value, mapper, codec, module) do
    data_type = data_type(module)

    quote do
      unquote(value)
      |> map_value_to_encode(unquote mapper)
      ~> fn result -> unquote(codec).encode(result)end
      ~>> fn details -> error unquote(data_type), unquote(value), nest_error(details) end
    end
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
