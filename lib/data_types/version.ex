defmodule MMS.Version do
  use MMS.Codec2

  alias MMS.{VersionInteger, Text}

  def decode(bytes = <<char, _::binary>>) when is_char(char) do
    bytes |> decode_with(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_with(VersionInteger)
  end

  def encode(string) when is_binary(string) do
    string |> encode_with(Text)
  end

  def encode(value) do
    value |> encode_with(VersionInteger)
  end
end
