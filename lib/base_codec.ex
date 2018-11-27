defmodule MM1.BaseCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      alias MM1.Result
      import MM1.Result
      import WAP.Guards

      use MM1.Codec

      def encode result do
        result.bytes
      end
    end
  end
end
