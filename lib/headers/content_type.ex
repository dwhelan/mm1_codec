defmodule MMS.ContentType do
  use MMS.Codec

  alias MMS.{ValueLength, Media}

  def decode(bytes = <<media, _::binary>>) when is_short_integer_byte(media) or is_char(media) do
    bytes
    |> decode_as(Media)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> ValueLength.decode(Media)
    ~> fn {media, rest} -> ok {{media}, rest} end
  end

  def encode({media}) do
    media
    |> ValueLength.encode(Media)
  end

  def encode(media) do
    media
    |> encode_with(Media)
  end
end
