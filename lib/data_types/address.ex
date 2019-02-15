defmodule MMS.Address do
  use MMS.Codec
  import CodecError

  alias MMS.EncodedStringValue
  alias MMS.{Either, IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress}

  @types [PhoneNumber, EmailAddress, IPv4Address, IPv6Address, UnknownAddress]

  def decode bytes do
    bytes |> EncodedStringValue.decode <~> EncodedStringValue.map(&map/1)
  end

  defp map string do
    string |> Either.apply_until_ok(@types, :map)
  end

  def encode value do
    value|> unmap ~> EncodedStringValue.encode ~>> module_error()
  end

  defp unmap([charset, address]) when is_atom(charset) do
    address |> unmap ~> OldOkError.Tuple.insert_at({charset}, 0)
  end

  defp unmap address do
    address |> Either.apply_until_ok(@types, :unmap)
  end
end

defmodule MMS.Address2 do
  use MMS.Codec2

  alias MMS.EncodedStringValue2

  def decode bytes do
    bytes
    |> EncodedStringValue2.decode
    ~> fn {string, rest} -> string |> String.split("/TYPE=") |> do_decode(rest) end
    ~>> fn details -> error bytes, details end
  end

  defp do_decode [email], rest do
    case email |> valid_email? do
      true  -> ok email, rest
      false -> error :email_address_missing_@
    end
  end

  defp do_decode [phone_number, "PLMN"], rest do
    case phone_number |> valid_phone_number? do
      true  -> ok phone_number, rest
      false -> error :invalid_phone_number
    end
  end

  defp do_decode [ipv4_string, "IPv4"], rest do
    ipv4_string
    |> to_charlist
    |> :inet.parse_ipv4strict_address
    ~> fn ipv4 -> ok ipv4, rest end
    ~>> fn _error -> error :invalid_ipv4_address end
  end


  defp do_decode [ipv6_string, "IPv6"], rest do
    ipv6_string
    |> String.replace(":", "::")
    |> to_charlist
    |> :inet.parse_ipv6strict_address
    ~> fn ipv6 -> ok ipv6, rest end
    ~>> fn _error -> error :invalid_ipv6_address end
  end

  def encode(address) when is_binary(address) do
    address
    |> check_address
    ~> fn string -> string |> EncodedStringValue2.encode end
    ~>> fn details -> error address, details end
  end

  def encode(ipv4) when is_tuple(ipv4) and tuple_size(ipv4) == 4 do
    ipv4
    |> :inet.ntoa
    |> OkError.return
    ~>> fn _error -> error :invalid_ipv4_address end
    ~> fn charlist -> EncodedStringValue2.encode to_string(charlist) <> "/TYPE=IPv4" end
    ~>> fn details -> error ipv4, details end
  end

  def encode(ipv6) when is_tuple(ipv6) and tuple_size(ipv6) == 8 do
    ipv6
    |> :inet.ntoa
    |> OkError.return
    ~> fn charlist -> charlist |> to_string |> String.replace("::", ":") end
    ~>> fn _error -> error :invalid_ipv6_address end
    ~> fn charlist -> EncodedStringValue2.encode to_string(charlist) <> "/TYPE=IPv6" end
    ~>> fn details -> error ipv6, details end
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
      false -> error :invalid_phone_number
    end
  end

  defp valid_phone_number? phone_number do
    phone_number |> String.match?(~r/^\+?[\d\-\.]+$/)
  end

  defp valid_email? email do
    email |> String.contains?("@")
  end
end
