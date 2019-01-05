defmodule MMS.Either do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import OkError

      @codecs opts[:codecs] || []

      def decode bytes do
        first_ok @codecs, & &1.decode(bytes) ~>> module_error()
      end

      def encode value do
        first_ok @codecs, & &1.encode(value) ~>> module_error()
      end
    end
  end
end
