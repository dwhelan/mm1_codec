defmodule Codec.Map do
  import OkError

  def get(value, map), do: Map.get map, value

  def with_index list do
    list |> Enum.with_index |> Enum.reduce(%{}, fn {v, i}, map -> map |> Map.put(i, v) end)
  end

  def invert map do
    map |> Enum.reduce(%{}, fn {k, v}, inverse -> inverse |> Map.put(v, k) end)
  end

  def map {value, rest}, map do
    case Map.get(map, value) do
      nil    -> error :not_found
      result -> ok {result, rest}
    end
  end

  def map value, map do
    case Map.get(map, value) do
      nil    -> error :not_found
      result -> ok result
    end
  end
end
