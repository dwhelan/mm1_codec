defmodule MM1.Codecs.Decorator do
  defmacro decorate codec, do: block do
    quote do
      use MM1.Codecs.Base

      @codec unquote codec

      def decode bytes do
        bytes |> @codec.decode |> map_result |> embed
      end

      def encode %MM1.Result{module: __MODULE__} = result do
        result |> extract |> encode_arg |> @codec.encode
      end

      def new value do
        value |> map_value |> @codec.new |> map_result |> embed
      end

      defp extract result do
        %MM1.Result{result | module: @codec}
      end

      unquote block
    end
  end
end
