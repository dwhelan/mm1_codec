defmodule MMS.EncodedString do
  use MMS.Either, [MMS.Text, MMS.EncodedStringValue]

  def map({string, charset}, fun) do
    string |> map(fun) ~> OldOkError.Tuple.insert_at({charset}, 0)
  end

  def map(string, fun) do
    fun.(string) ~> ok
  end
end

defmodule MMS.EncodedString2 do
  use MMS.Codec2

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) do
    bytes |> MMS.Text.decode
  end

  def decode(bytes) when is_binary(bytes) do
    error :invalid_text, bytes, :first_byte_must_be_a_char
  end

  def encode(text) when is_binary(text) do
    text |> MMS.Text.encode
  end
end
