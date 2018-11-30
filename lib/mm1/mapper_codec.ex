defmodule MM1.MapperCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec], map: opts[:map]] do
      @map         map
      @codec       codec
      @reverse_map Enum.reduce map, %{}, fn {k,v}, reverse_map -> Map.put(reverse_map, v, k) end

      import MM1.DecoratorCodec

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
end
