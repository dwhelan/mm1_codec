defmodule MM1.MapperCodec do
  def reverse map do
    Enum.reduce map, %{}, fn {k,v}, reverse_map -> Map.put(reverse_map, v, k) end
  end

  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec], map: opts[:map]] do
      @map         map
      @codec       codec
      @reverse_map MM1.MapperCodec.reverse map

      use MM1.BaseCodec
      alias MM1.Result

      def decode bytes do
        bytes |> @codec.decode |> map_result |> embed
      end

      def encode result do
        result |> unmap_result |> @codec.encode
      end

      def new value do
         value |> map_value |> @codec.new |> map_result |> embed
      end



      def map_result result do
        %Result{result | value: Map.get(@map, result.value, result.value)}
      end

      defp unmap_result result do
        result
      end

      defp map_value value do
        Map.get(@reverse_map, value, value)
      end
    end
  end
end
