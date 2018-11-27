defmodule MM1.WrapperCodec do

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      use MM1.BaseCodec, custom_encode: true

      @wrapped_module opts[:codec]

      def decode bytes do
        result = @wrapped_module.decode bytes
        ok result, <<>>, result.rest
      end

      def encode result do
        @wrapped_module.encode result.value
      end

      def new value do
        ok @wrapped_module.new value
      end
    end
  end
end
