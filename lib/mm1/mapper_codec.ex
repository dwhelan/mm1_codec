defmodule MM1.MapperCodec do
  def missing_codec do
    raise "Please provide a codec option: use MM1.MapperCode, codec: <codec>, map: <map>"
  end

  def missing_map do
    raise "Please provide a map option: use MM1.MapperCode, codec: <codec>, map: <map>"
  end

  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec], map: opts[:map]] do
      @codec       codec || MM1.MapperCodec.missing_codec()
      @map         map   || MM1.MapperCodec.missing_map()
      @reverse_map Enum.reduce @map, %{}, fn {k,v}, reverse_map -> Map.put(reverse_map, v, k) end

      alias MM1.Result
      import Result

      def decode bytes do
        bytes |> @codec.decode |> map_result |> embed
      end

      def encode %Result{module: __MODULE__} = result do
        %Result{result | module: @codec } |> @codec.encode
      end

      def new value do
         value |> map_value |> @codec.new |> map_result |> embed
      end

      def map_result result do
        %Result{result | value: Map.get(@map, result.value, result.value)}
      end

      defp unmap_result result do
        %Result{result | module: @codec }
      end

      defp map_value value do
        Map.get(@reverse_map, value, value)
      end
    end
  end
end
