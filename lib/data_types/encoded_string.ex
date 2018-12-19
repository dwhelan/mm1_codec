defmodule MMS.EncodedString do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.{Composer, Charset, String}

  def decode(<<byte, _::binary>> = bytes) when is_string(byte) do
    bytes |> String.decode
  end

  def decode bytes do
    bytes |> Composer.decode({Charset, String})
  end

  def encode(string) when is_binary(string) do
    string |> String.encode
  end

  def encode {charset, string} do
    {charset, string} |> Composer.encode({Charset, String})
  end
end
