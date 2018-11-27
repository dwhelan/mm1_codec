defmodule MM1.WrapperCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      use MM1.BaseDecoder

      @codec codec

      def decode bytes do
        wrap @codec.decode bytes
      end

      def encode result do
        @codec.encode result.value
      end

      def new value do
        wrap @codec.new value
      end

      defp wrap result do
        %MM1.Result{result | module: __MODULE__, value: result, bytes: <<>>}
      end
    end
  end
end
