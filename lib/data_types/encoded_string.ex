defmodule MMS.EncodedString do
  import MMS.DataTypes

  alias MMS.{Composer, Charset, Text}

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) do
    Text.decode bytes
  end

  def decode bytes do
    Composer.decode bytes, [Charset, Text]
  end

  def encode(string) when is_binary(string) do
    Text.encode string
  end

  def encode {string, charset} do
    Composer.encode [charset, string], [Charset, Text]
  end
end
