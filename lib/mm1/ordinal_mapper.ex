defmodule MM1.OrdinalMapper do
  defmacro __using__(opts) do
    quote bind_quoted: [values: opts[:values]] do
      import MM1.Mapper

      map = values |> Enum.with_index |> Enum.reduce(%{}, fn {v, index}, acc -> Map.put(acc, index, v) end)
      MM1.Mapper.build_mapper map
    end
  end
end
