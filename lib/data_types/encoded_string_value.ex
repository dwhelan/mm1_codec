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

  use MMS.Codec2

  alias MMS.EncodedStringValue.TextStringWithCharset
  alias MMS.TextString

  def decode(<<byte, _::binary>> = bytes) when is_text(byte) do
    bytes
    |> TextString.decode
    ~>> fn details -> error bytes, error_detail_list(details) end
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> TextStringWithCharset.decode
    ~>> fn details -> error bytes, error_detail_list(details) end
  end

  def encode(text) when is_binary(text) do
    text
    |> TextString.encode
    ~>> fn details -> error text, details end
  end

  def encode({text, charset}) when is_binary(text) do
    {text, charset}
    |> TextStringWithCharset.encode
    ~>> fn details -> error {text, charset}, details end
  end

  defmodule TextStringWithCharset do
    use MMS.Codec2

    alias MMS.{ValueLengthList, Charset}

    def decode bytes do
      ValueLengthList.decode(bytes, [&(Charset.decode/1), &(TextString.decode/1)])
      ~> fn {[charset, text], rest} -> ok {text, charset}, rest end
    end

    def encode {text, charset} do
      ValueLengthList.encode([charset, text], [&(Charset.encode/1), &(TextString.encode/1)])
    end
  end
end

