defmodule MM1.OrdinalMapper do
  defmacro __using__(opts) do
    quote bind_quoted: [values: opts[:values]] do
      map = values |> Enum.with_index |> Enum.reduce(%{}, fn {v, index}, acc -> Map.put(acc, index, v) end)

      use MM1.Mapper, map: map
    end
  end
end
