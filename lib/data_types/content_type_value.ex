defmodule MMS.ContentTypeValue do
  @moduledoc """
  8.4.2.24 Content type field

  The following rules are used to encode content type values.
  The short form of the Content-type-value MUST only be used when the well-known media is in the range of 0-127 or a text string.

  In all other cases the general form MUST be used.

  Content-type-value = Constrained-media | Content-general-form

  """
  use MMS.Codec

  alias MMS.{MediaType, ContentGeneralForm}

  def decode(bytes = <<media, _::binary>>) when is_short_integer_byte(media) or is_char(media) do
    bytes
    |> decode_as(MediaType)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> decode_as(ContentGeneralForm)
  end

  def encode(media) do
    media
    |> encode_as(MediaType)
    ~>> fn _ -> media |> encode_as(ContentGeneralForm) end
  end
end
