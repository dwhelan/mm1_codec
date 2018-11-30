defmodule MM1.CoreMapper do
  alias MM1.Result

  def map %Result{} = result, map do
    %Result{result | value: map(result.value, map)}
  end

  def map value, map do
    Map.get(map, value, value)
  end
end

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
      import MM1.CoreMapper

      def decode bytes do
        bytes |> @codec.decode |> map
      end

      def encode %Result{module: __MODULE__} = result do
        @codec.encode %Result{result | module: @codec }
      end

      def new value do
        value |> map(@reverse_map) |> @codec.new |> map
      end

      def map result do
        result |> map(@map) |> embed
      end

      defp map_result do
      end

      defp unmap_result do
      end

      defp map_new do
      end
    end
  end
end
