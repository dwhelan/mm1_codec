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
        bytes |> @codec.decode |> map
      end

      def encode %Result{module: __MODULE__} = result do
        @codec.encode %Result{result | module: @codec }
      end

      def new value do
        Map.get(@reverse_map, value, value) |> @codec.new |> map
      end

      def map result do
        %Result{result | value: Map.get(@map, result.value, result.value)} |> embed
      end
    end
  end
end
