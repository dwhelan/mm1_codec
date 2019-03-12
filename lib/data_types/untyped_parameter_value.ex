defmodule MMS.UntypedParameter do
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

  alias MMS.{TextString, List}

  def decode(bytes) do
    bytes
    |> List.decode([TextString, TextString])
    ~> fn {[name, value], rest} ->
        decode_ok {name, value}, rest
       end
  end

  def encode({name, value}) do
    [name, value]
    |> List.encode([TextString, TextString])
  end
end
