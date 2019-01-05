defmodule MMS.Either do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import OkError

      @codecs opts[:codecs] || []

      def decode bytes do
        decode bytes, @codecs
      end

      defp decode _, [] do
        error()
      end

      defp decode bytes, [codec | codecs] do
        bytes |> codec.decode ~>> cons decode(bytes, codecs)
      end

      def encode value do
        do_encode value, @codecs
      end

      defp do_encode _, [] do
        error()
      end

      defp do_encode value, [codec | codecs] do
        value |> codec.encode ~>> cons do_encode(value, codecs)
      end
    end
  end
end
