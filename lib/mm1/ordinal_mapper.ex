defmodule MM1.OrdinalMapper do
  defmacro build_mapper(list) do
    quote bind_quoted: [list: list] do
      import MM1.Mapper

      map = list |> Enum.with_index |> Enum.reduce(%{}, fn {v, index}, acc -> Map.put(acc, index, v) end)
      MM1.Mapper.build_mapper map
    end
  end
end
