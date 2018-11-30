defmodule MM1.WrapperCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      use MM1.BaseDecoder

      @codec codec

      def decode bytes do
        bytes |> @codec.decode |> map_result
      end

      def encode result do
        result.value |> @codec.encode
      end

      def new value do
        value |> @codec.new |> map_result
      end

      defp map_result result do
        %MM1.Result{result | value: result, bytes: <<>>} |> embed
      end
    end
  end
end
