defmodule MMS.Prefix do
  use MMS.Codec

  defmacro __using__(opts \\ []) do
    build_codec opts
  end

  defp build_codec(prefix: prefix, codec: codec) do
    quote do
      use MMS.Codec

      def decode <<unquote(prefix), bytes::binary>> do
        bytes |> unquote(codec).decode
      end

      def decode _ do
        module_error()
      end

      def encode(value) do
        value |> unquote(codec).encode ~> prepend(<<unquote(prefix)>>)
      end
    end
  end

  defp build_codec _ do
    raise ArgumentError, """
      "use MMS.Prefix" expects to be passed options with "prefix" byte and a "codec". For example:


        defmodule MyCodec do
          use MMS.Prefix, prefix: 42, codec: MMS.ShortInteger
        end
      """
  end
end
