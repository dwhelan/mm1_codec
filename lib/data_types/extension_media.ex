defmodule MMS.ExtensionMedia do
  @moduledoc """
  8.4.2.1 Basic rules

  Extension-media = *TEXT End-of-string

  This encoding is used for media values, which have no well-known binary encoding.

  The `MMS.TEXT` module supports `*TEXT End-of-string`
  """

  use MMS.Codec
  alias MMS.Text

  def decode <<"\0", rest::binary>> do
    ok "", rest
  end

  def decode bytes do
    bytes
    |> decode_as(Text)
  end

  def encode "" do
    ok "\0"
  end

  def encode value do
    value
    |> encode_as(Text)
  end
end
