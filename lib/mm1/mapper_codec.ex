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

      import MM1.Result

      def decode bytes do
        bytes |> @codec.decode |> map |> embed
      end

      def encode %MM1.Result{module: __MODULE__} = result do
        @codec.encode %MM1.Result{result | module: @codec }
      end

      def new value do
        value |> reverse_map |> @codec.new |> map |> embed
#        (@reverse_map[value] || value) |> @codec.new |> embed
      end

      defp map result do
        value = @map[result.value]
        mapped_value = if is_nil(value) do
          result.value
        else
          value
        end
        %MM1.Result{result | value: mapped_value}
      end

      defp reverse_map value do
        reversed_value = @reverse_map[value]
        if is_nil(reversed_value) do
          value
        else
          reversed_value
        end
      end
    end
  end
end
#defmodule MM1.ComposeCodec do
#  defmacro __using__(opts) do
#    quote bind_quoted: [f: opts[:f], g: opts[:f]] do
#      @f f
#      @g g
#
#      def decode bytes do
#        bytes |> @g.decode |> @f.decode
#      end
#
#      def encode result do
#       result |> @g.encode | @f.encode
#      end
#
#      def new value do
#        value |> @g.new | @f.new
#      end
#
#      def map %Result{} = result do
#        %Result{result | value: @map[value] || value}
#      end
#    end
#  end
#end
