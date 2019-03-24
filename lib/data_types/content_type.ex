defmodule MMS.ContentType do
  @moduledoc """
  8.4.2.24 Content type field

  The following rules are used to encode content type values.
  The short form of the Content-type-value MUST only be used when the well-known media is in the range of 0-127 or a text string.

  In all other cases the general form MUST be used.

  Content-type-value = Constrained-media | Content-general-form
  Content-general-form = Value-length Media-type

  We simplify this to:

  Content-type-value = Constrained-media | Value-length Media-type
  """
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
    |> encode_as(Media)
  end
end
