defmodule MMS.EncodedString do
  import MMS.DataTypes

  alias MMS.{Composer, Charset, String}

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) do
    String.decode bytes
  end

  def decode bytes do
    Composer.decode bytes, [Charset, String]
  end

  def encode(string) when is_binary(string) do
    String.encode string
  end

  def encode [charset, string] do
    Composer.encode [charset, string], [Charset, String]
  end
end
