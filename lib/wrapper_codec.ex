defmodule MM1.WrapperCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      use MM1.Codec

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
    end
  end
end
