defmodule MMS.ConstrainedMedia do
  @moduledoc """
  8.4.2.7 Accept field

  Constrained-media = Constrained-encoding
  """

  use MMS.Codec
  alias MMS.ConstrainedEncoding

  def decode bytes do
    bytes
    |> decode_as(ConstrainedEncoding)
  end

  def encode value do
    value
    |> encode_as(ConstrainedEncoding)
  end
end
