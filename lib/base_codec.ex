defmodule MM1.BaseCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import WAP.Guards

      use MM1.BaseDecoder

      def encode result do
        result.bytes
      end
    end
  end
end
