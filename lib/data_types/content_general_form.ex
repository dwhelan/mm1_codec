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
  end

  def encode(media_type) do
    media_type
    |> ValueLength.encode(MediaType)
  end
end
