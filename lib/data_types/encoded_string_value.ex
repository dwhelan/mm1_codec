defmodule MMS.EncodedStringValue do
  @moduledoc """

  Encoded-string-value = Text-string | Value-length Char-set Text-string

  The Char-set values are registered by IANA as MIBEnum value.
  UTF-8 character-set encoding SHOULD be supported in Encoded-string-value.
  If the MMS Client uses UTF-8 character-set encoding, the Char-set parameter SHOULD be used to indicate its usage.

  Encoding according to [RFC2047] MAY be supported in the MMS Client and/or MMS Proxy-Relay.
  Encoding according to [RFC2047] SHOULD only be used without “Value-length Char-set” parameters.
  [RFC2047] encoding for UTF-8 character- set encoding MAY be supported in the MMS Client and/or MMS Proxy-Relay.
  """

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

  def encode({text, charset}) when is_binary(text) do
    {text, charset} |> MMS.TextStringWithCharset.encode
  end
end

defmodule MMS.TextStringWithCharset do
  use MMS.Codec2

  alias MMS.{ValueLengthList, Charset, Text}

  def decode bytes do
    ValueLengthList.decode(bytes, [&(Charset.decode/1), &(Text.decode/1)])
    ~> fn {[charset, text], rest} -> ok {text, charset}, rest end
  end

  def encode {text, charset} do
    ValueLengthList.encode([charset, text], [&(Charset.encode/1), &(Text.encode/1)])
  end
end
