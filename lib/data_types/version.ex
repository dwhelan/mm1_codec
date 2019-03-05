defmodule MMS.Version do
  @moduledoc """
  Specification: WAP-230-WSP-20010705-a, 8.4.2.3 Parameter Values

  Version-value = ShortInteger-integer | Text-string

  The VersionInteger codec is responsible for interpreting the major and minor verions from a ShortInteger
  """
  use MMS.Codec

  alias MMS.{VersionInteger, Text}

  def decode(bytes = <<char, _::binary>>) when is_char(char) do
    bytes |> decode_as(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_as(VersionInteger)
  end

  def encode(string) when is_binary(string) do
    string |> encode_as(Text)
  end

  def encode(value) do
    value |> encode_as(VersionInteger)
  end
end
