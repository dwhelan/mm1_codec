defmodule MMS.Either do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import OkError

      @codecs opts[:codecs] || []

      def decode bytes do
        decode :_, bytes, @codecs
      end

      defp decode _, _, [] do
        error()
      end

      defp decode _, bytes, [codec | codecs] do
        bytes |> codec.decode ~>> decode(bytes, codecs)
      end

      def encode value do
        do_encode :_, value, @codecs
      end

      defp do_encode _, _, [] do
        error()
      end

      defp do_encode _, value, [codec | codecs] do
        value |> codec.encode ~>> do_encode(value, codecs)
      end
    end
  end
end
