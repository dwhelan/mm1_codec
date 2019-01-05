defmodule OkError.Map do
  def get(value, map), do: Map.get map, value

  def from_list list do
    list |> Enum.with_index |> Enum.reduce(%{}, fn {v, i}, map -> map |> Map.put(i, v) end)
  end

  def invert map do
    map |> Enum.reduce(%{}, fn {k, v}, inverse -> inverse |> Map.put(v, k) end)
  end
end
