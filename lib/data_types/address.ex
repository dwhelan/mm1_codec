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
  use MMS.Codec
  alias MMS.Text

  def decode bytes do
    bytes |> decode(Text, &to_tuple/1)
  end

# TODO: remove 'def to_tuple([email]' by having caller use ValueLength.decode rather than ValueLengthList.decode
  defp to_tuple([email]), do: {email,  ""  }
  defp to_tuple(text),    do: text |> split |> to_tuple

  defp split(text), do: text |> String.split("/TYPE=")

  def encode(address) when is_address(address) do
    address |> encode(Text, &to_text/1)
  end

  defp to_text({email,  ""  }), do: email
  defp to_text({device, type}), do: "#{device}/TYPE=#{type}"
end
