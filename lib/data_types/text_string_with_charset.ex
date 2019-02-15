defmodule MMS.TextStringWithCharset do
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
#
  alias MMS.{ValueLengthList, Charset, Text}

  def decode bytes do
    ValueLengthList.decode(bytes, [&(Charset.decode/1), &(Text.decode/1)])
  end

  def encode values = [charset, text] do
    ValueLengthList.encode(values, [&(Charset.encode/1), &(Text.encode/1)])
  end
end

