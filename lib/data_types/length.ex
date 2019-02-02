defmodule MMS.Length do
  use MMS.Either, [MMS.ShortLength, MMS.Uint32Length]
end

defmodule MMS.ShortLength do
  use Codec2

  def decode(<<value, rest::binary>>) when is_short_length(value) do
    ok value, rest
  end

  def decode _ do
    error code: :invalid_short_length
  end

  def encode(value) when is_short_length(value) do
    ok <<value>>
  end

  def encode _ do
    error code: :invalid_short_length
  end
end

defmodule MMS.Uint32Length do
  @length_quote 31

  use MMS.Prefix, prefix: @length_quote, codec: MMS.Uint32
end
