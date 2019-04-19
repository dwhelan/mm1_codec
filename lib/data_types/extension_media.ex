defmodule MMS.ExtensionMedia do
  @moduledoc """
  8.4.2.1 Basic rules

  Extension-media = *TEXT End-of-string

  This encoding is used for media values, which have no well-known binary encoding.

  The `MMS.TEXT` module supports `*TEXT End-of-string`
  """

  use MMS.Codec
  import MMS.As
  alias MMS.Text

  @end_of_string "\0"

  def decode <<@end_of_string, rest::binary>> do
    ok "", rest
  end

  def decode bytes do
    bytes
    |> decode_as(Text)
  end

  def encode "" do
    ok <<@end_of_string>>
  end

  def encode value do
    value
    |> encode_as(Text)
  end
end
