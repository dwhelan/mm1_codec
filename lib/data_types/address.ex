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
      |> do_decode
      |> ok(rest) end
    ~>> fn details -> decode_error bytes, details end
  end

  defp do_decode([email]),         do: {email, :email}
  defp do_decode([phone, "PLMN"]), do: phone
  defp do_decode([ipv4, "IPv4"]),  do: {ipv4, :ipv4}
  defp do_decode([ipv6, "IPv6"]),  do: {ipv6, :ipv6}
  defp do_decode([other, type]),   do: {other, type}

  def encode(address) do
    address
    |> do_encode
    ~> Text.encode
    ~>> fn details -> encode_error address, details end
  end

  def do_encode({email, :email}) when is_binary(email), do: ok email
  def do_encode(phone)           when is_binary(phone), do: ok "#{phone}/TYPE=PLMN"
  def do_encode({ipv4, :ipv4})   when is_binary(ipv4),  do: ok "#{ipv4}/TYPE=IPv4"
  def do_encode({ipv6, :ipv6})   when is_binary(ipv6),  do: ok "#{ipv6}/TYPE=IPv6"
  def do_encode({address, "PLMN"}) when is_binary(address),  do: error :encode_phone_numbers_without_type
  def do_encode({address, "IPv4"}) when is_binary(address),  do: error :encode_ipv4_address_with_atom
  def do_encode({address, "IPv6"}) when is_binary(address),  do: error :encode_ipv6_address_with_atom
  def do_encode({address, type}) when is_binary(address) and is_binary(type),  do: ok "#{address}/TYPE=#{type}"
end
