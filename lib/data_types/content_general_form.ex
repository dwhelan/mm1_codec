defmodule MMS.ContentGeneralForm do
  @moduledoc """
  8.4.2.24 Content type field

  Content-general-form = Value-length Media-type

  """
  use MMS.Codec
  import MMS.Length
  alias MMS.{ValueLength, MediaType}

  def decode bytes do
    bytes
    |> decode_with_length(ValueLength, MediaType)
  end

  def encode(value) do
    value
    |> encode_with_length(ValueLength, MediaType)
  end
end
