defmodule MMS.ContentTypeValue do
  @moduledoc """
  8.4.2.24 Content type field

  The following rules are used to encode content type values.
  The short form of the Content-type-value MUST only be used when the well-known media is in the range of 0-127 or a text string.

  In all other cases the general form MUST be used.

  Content-type-value = Constrained-media | Content-general-form

  """
  use MMS.Codec

  alias MMS.{ConstrainedMedia, ContentGeneralForm}

  def decode(bytes = <<media, _::binary>>) when is_short_integer_byte(media) do
    bytes
    |> decode_as(ConstrainedMedia)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> decode_as(ContentGeneralForm)
  end

  def encode(constrained_media) when is_short_integer(constrained_media) do
    constrained_media
    |> encode_as(ConstrainedMedia)
  end

  def encode(media) do
    media
    |> encode_as(ContentGeneralForm)
  end
end
