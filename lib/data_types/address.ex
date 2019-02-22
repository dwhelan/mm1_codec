defmodule MMS.Address do
  @moduledoc """
  address = ( e-mail / device-address )
  e-mail = "Joe User <joe@user.org>" ; corresponding syntax defined in RFC822 per header field
  device-address = ( global-phone-number "/TYPE=PLMN" )
                   / ( ipv4 "/TYPE=IPv4" )
                   / ( ipv6 "/TYPE=IPv6" )
                   / ( escaped-value "/TYPE=" address-type )
  address-type = 1*address-char; A network bearer address type [WDP]
  address-char = ( ALPHA / DIGIT / "_" )
  escaped-value = 1*( safe-char )
  ; the actual value escaped to use only safe characters by replacing
  ; any unsafe-octet with its hex-escape
  safe-char = ALPHA / DIGIT / "+" / "-" / "." / "%" / "_"
  unsafe-octet = %x00-2A / %x2C / %x2F / %x3A-40 / %x5B-60 / %x7B-FF
  hex-escape = "%" 2HEXDIG ; value of octet as hexadecimal value
  global-phone-number = ["+"] 1*( DIGIT / written-sep )
  written-sep =("-"/".")
  ipv4 = 1*3DIGIT 3( "." 1*3DIGIT ) ; IPv4 address value
  ipv6 = 4HEXDIG 7( ":" 4HEXDIG ) ; IPv6 address per RFC 2373
  """
  use MMS.Codec2

  alias MMS.Text

  def decode bytes do
    bytes
    |> Text.decode
    ~> fn {text, rest} ->
      text
      |> String.split("/TYPE=")
      |> to_tuple
      |> ok(rest) end
    ~>> fn details -> decode_error bytes, details end
  end

  defp to_tuple([string, type]), do: {string, type}
  defp to_tuple([email]),        do: {email,  ""  }

  def encode(address = {string, type}) when is_binary(string) and is_binary(type) do
    address
    |> to_text
    |> Text.encode
    ~>> fn details -> encode_error address, details end
  end

  defp to_text({email,  ""  }), do: email
  defp to_text({string, type}), do: "#{string}/TYPE=#{type}"
end
