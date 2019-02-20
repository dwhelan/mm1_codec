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
    ~> fn {text, rest} -> text |> String.split("/TYPE=") |> do_decode(rest) end
    ~>> fn details -> decode_error bytes, details end
  end

  defp do_decode [email], rest do
    case email |> valid_email? do
      true  -> ok email, rest
      false -> error :email_address
    end
  end

  defp do_decode [phone_number, "PLMN"], rest do
    case phone_number |> valid_phone_number? do
      true  -> ok phone_number, rest
      false -> error :phone_number
    end
  end

  defp do_decode [ipv4_string, "IPv4"], rest do
    ipv4_string
    |> to_charlist
    |> :inet.parse_ipv4strict_address
    ~> fn ipv4 -> ok ipv4, rest end
    ~>> fn _error -> error :ipv4_address end
  end

  defp do_decode [ipv6_string, "IPv6"], rest do
    ipv6_string
    |> String.replace(":", "::")
    |> to_charlist
    |> :inet.parse_ipv6strict_address
    ~> fn ipv6 -> ok ipv6, rest end
    ~>> fn _error -> error :ipv6_address end
  end

  defp do_decode [address, type], rest do
    ok {address, type}, rest
  end

  def encode(address) when is_binary(address) do
    address
    |> check_address
    ~> fn string -> string |> Text.encode end
    ~>> fn details -> error address, details end
  end

  def encode(ipv4) when is_tuple(ipv4) and tuple_size(ipv4) == 4 do
    ipv4
    |> :inet.ntoa
    |> OkError.return
    ~>> fn _error -> error :ipv4_address end
    ~> fn charlist -> Text.encode to_string(charlist) <> "/TYPE=IPv4" end
    ~>> fn details -> error ipv4, details end
  end

  def encode(ipv6) when is_tuple(ipv6) and tuple_size(ipv6) == 8 do
    ipv6
    |> :inet.ntoa
    |> OkError.return
    ~> fn charlist -> charlist |> to_string |> String.replace("::", ":") end
    ~>> fn _error -> error :ipv6_address end
    ~> fn charlist -> Text.encode to_string(charlist) <> "/TYPE=IPv6" end
    ~>> fn details -> error ipv6, details end
  end

  def encode({address, type}) when is_binary(address) and type not in ["IPv4", "IPv6", "PLMN"] do
    address <> "/TYPE=#{type}"
    |> Text.encode
  end

  defp check_address string do
    case string |> valid_email? do
      true  -> ok string
      false -> string |> check_phone_number
    end
  end

  defp check_phone_number phone_number do
    case phone_number |> valid_phone_number? do
      true -> ok phone_number <> "/TYPE=PLMN"
      false -> error :phone_number
    end
  end

  defp valid_phone_number? phone_number do
    phone_number |> String.match?(~r/^\+?[\d\-\.]+$/)
  end

  defp valid_email? email do
    email |> String.contains?("@")
  end
end
