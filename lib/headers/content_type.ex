defmodule MMS.ContentType do
  use MMS.Codec2

  alias MMS.{ValueLength, Media}

  def decode(bytes = <<media, _::binary>>) when is_short_integer_byte(media) or is_char(media) do
    bytes |> decode_with(Media)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> ValueLength.decode(
         fn value_bytes ->
           value_bytes
           |> Media.decode
           ~> fn {media, rest} -> ok {{media}, rest} end
         end
       )
  end

  def encode({media}) do
    media
    |> ValueLength.encode(
         fn value ->
           value |> Media.encode
         end
       )
  end

  def encode(media) do
    media |> encode_with(Media)
  end
end

