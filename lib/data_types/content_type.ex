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

  alias MMS.{ValueLength, MediaType, ContentGeneralForm}

  def decode(bytes = <<media, _::binary>>) when is_short_integer_byte(media) or is_char(media) do
    bytes
    |> decode_as(MediaType)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> decode_as(ContentGeneralForm)
  end

  def encode({media}) do
    media
    |> encode_as(ContentGeneralForm)
  end

  def encode(media) do
    media
    |> encode_as(MediaType)
  end
end

defmodule MMS.ContentGeneralForm do
  @moduledoc """
  8.4.2.24 Content type field

  Content-general-form = Value-length Media-type

  """
  use MMS.Codec

  alias MMS.{ValueLength, MediaType}

  def decode bytes do
    bytes
    |> ValueLength.decode(MediaType)
    ~> fn {media_type, rest} -> ok {{media_type}, rest} end
  end

  def encode(media_type) do
    media_type
    |> ValueLength.encode(MediaType)
  end
end
