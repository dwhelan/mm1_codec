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

  use MMS.Codec

  alias MMS.{TextString, Charset, ValueLengthList}

  def decode(<<byte, _::binary>> = bytes) when is_text(byte) do
    bytes
    |> decode_as(TextString)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> ValueLengthList.decode([Charset, TextString])
    ~> fn {[charset, text], rest} -> {text, charset} |> decode_ok(rest) end
    ~>> & decode_error(bytes, &1)
  end

  def encode(text) when is_binary(text) do
    text
    |> encode_as(TextString)
  end

  def encode({text, charset}) when is_binary(text) do
    [charset, text]
    |> ValueLengthList.encode([Charset, TextString])
    ~>> & decode_error({text, charset}, &1)
  end
end
