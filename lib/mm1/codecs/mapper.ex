defmodule MM1.Codecs.Mapper do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec], map: opts[:map]] do
      @map         map
      @codec       codec
      @reverse_map Enum.reduce map, %{}, fn {k,v}, reverse_map -> Map.put(reverse_map, v, k) end

      import MM1.Codecs.Decorator

      decorate codec do
        def map_result result do
          %MM1.Result{result | value: Map.get(@map, result.value, result.value)}
        end

        defp encode_arg result do
          result
        end

        defp map_value value do
          Map.get @reverse_map, value, value
        end
      end
    end
  end

  def ordinal_map values do
    values |> Enum.with_index |> Enum.reduce(%{}, fn {v, index}, map -> Map.put(map, index+128, v) end)
  end
end
