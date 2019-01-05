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

defmodule MMS.Uint32Length do
  use MMS.Codec

  alias MMS.Uint32

  @length_quote 31

  def decode <<@length_quote, bytes::binary>> do
    bytes |> Uint32.decode
  end

  def encode(value) when is_uint32(value) do
    value |> Uint32.encode ~> prepend(<<@length_quote>>)
  end

  defaults()
end
