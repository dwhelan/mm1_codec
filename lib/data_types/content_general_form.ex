defmodule MMS.ContentGeneralForm do
  @moduledoc """
  8.4.2.24 Content type field

  Content-general-form = Value-length Media-type

  """
  use MMS.Codec
  import MMS.ValueLength
  alias MMS.{ValueLength, MediaType}

  def decode bytes do
    bytes
    |> decode_as(MediaType)
  end

  def encode(media_type) do
    media_type
    |> ValueLength.encode(MediaType)
  end
end
