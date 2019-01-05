defmodule MMS.Length do
  use MMS.Either, [MMS.ShortLength, MMS.Uint32Length]
end

defmodule MMS.ShortLength do
  use MMS.Codec

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    ok value, rest
  end

  def encode(value) when is_short_length(value) do
    ok <<value>>
  end

  defaults()
end

defmodule MMS.Prefix do
  use MMS.Codec

  defmacro __using__(opts \\ []) do
    build_codec opts
  end

  defp build_codec prefix: prefix, codec: codec do
    quote do
      use MMS.Codec

      def decode <<unquote(prefix), bytes::binary>> do
        bytes |> unquote(codec).decode
      end

      def decode _ do
        error()
      end

      def encode(value) do
        value |> unquote(codec).encode ~> prepend(<<unquote(prefix)>>)
      end
    end
  end
end

defmodule MMS.Uint32Length do
  use MMS.Prefix, prefix: 31, codec: MMS.Uint32
end
