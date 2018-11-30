defmodule MM1.WrapperCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      use MM1.BaseDecoder

      @codec codec

      def decode bytes do
        bytes |> @codec.decode |> wrap
      end

      def encode result do
        result.value |> @codec.encode
      end

      def new value do
        value |> @codec.new |> wrap
      end

      defp wrap result do
        embed %MM1.Result{result | value: result, bytes: <<>>}
      end
    end
  end
end
