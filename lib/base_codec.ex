defmodule MM1.BaseCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      alias MM1.Result
      import MM1.Result
      import WAP.Guards

      if ! opts[:custom_encode] do
        def encode result do
          result.bytes
        end
      end

      def decode <<>> do
        error nil, :insufficient_bytes
      end

      def new nil do
        error nil, :value_cannot_be_nil
      end
    end
  end
end
