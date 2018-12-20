defmodule MMS.Address do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.EncodedString
  alias MMS.Address.{IPv4, IPv6, PhoneNumber, Email, Unknown}

  def decode bytes do
    case_ok EncodedString.decode bytes do
      {value, rest} -> map value, rest
    end
  end

  defp map {codec, string}, rest do
    case_ok map string do
      string -> ok {codec, string}, rest
    end
  end

  defp map string, rest do
    case_ok map string do
      string -> ok string, rest
    end
  end

  defp map string do
    [address | type] = string |> String.split("/TYPE=", parts: 2)

    case type do
      ["IPv4"] -> IPv4.map address
      ["IPv6"] -> IPv6.map address
      ["PLMN"] -> PhoneNumber.map address
      []       -> Email.map string
      _        -> Unknown.map string
    end
  end

  def encode {charset, value} do
    {charset, unmap(value)} |> EncodedString.encode
  end

  def encode value do
    value |> unmap |> EncodedString.encode
  end

  defp unmap value do
    cond do
      is_ipv4_address value -> IPv4.unmap value
      is_ipv6_address value -> IPv6.unmap value
      contains_type?  value -> Unknown.unmap value
      Email.is_email? value -> Email.unmap value
      true                  -> PhoneNumber.unmap value
    end
  end

  defp contains_type? string do
    String.contains? string, "/TYPE"
  end
end
