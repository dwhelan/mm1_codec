defmodule MMS.EncodedStringValue do
  use MMS.Either, [MMS.Text, MMS.TextStringWithCharset]

  def map([charset, string], fun) do
    string |> map(fun) ~> OldOkError.Tuple.insert_at({charset}, 0)
  end

  def map(string, fun) do
    fun.(string) ~> ok
  end
end

defmodule MMS.EncodedStringValue2 do
  use MMS.Codec2

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) do
    bytes |> MMS.Text.decode
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> MMS.TextStringWithCharset.decode
  end

  def encode(text) when is_binary(text) do
    text |> MMS.Text.encode
  end

  def encode([charset, text]) when is_binary(text) do
    text |> MMS.TextStringWithCharset.encode([charset, text])
  end
end
