defmodule MM1.BaseCodec do
  defmacro __using__(_opts) do
    quote do
      use MM1.BaseDecoder

      def encode result do
        result.bytes
      end
    end
  end
end
