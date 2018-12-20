defmodule MMS.Address.PhoneNumber do
  import MMS.OkError

  def map string do
    case MMS.Address.Email.is_email? string do
      false -> ok string
      true  -> error :invalid_phone_number
    end
  end

  def unmap value do
    value <> "/TYPE=PLMN"
  end
end

defmodule MMS.Address.Email do
  import MMS.OkError

  def map string do
    case is_email? string do
      true  -> ok string
      false -> error :invalid_email
    end
  end

  def unmap value do
    value
  end

  def is_email? string do
    String.contains? string, "@"
  end
end

defmodule MMS.Address.IPv4 do
  import MMS.OkError

  def map string do
    case string |> to_charlist |> :inet.parse_ipv4_address do
      {:ok, ipv4} -> ok ipv4
      _           -> error :invalid_ipv4_address
    end
  end

  def unmap value do
    (value |> :inet.ntoa |> to_string) <> "/TYPE=IPv4"
  end
end

defmodule MMS.Address.Unknown do
  import MMS.OkError

  def map string do
     ok string
  end

  def unmap value do
    value
  end
end

defmodule MMS.Address.IPv6 do
  import MMS.OkError

  def map string do
    case string |> double_colon |> to_charlist |> :inet.parse_ipv6_address do
      {:ok, ipv6} -> ok ipv6
      _           -> error :invalid_ipv6_address
    end
  end

  def unmap value do
    (value |> :inet.ntoa |> to_string |> single_colon) <> "/TYPE=IPv6"
  end

  defp double_colon string do
    Regex.replace ~r/:/, string, "::"
  end

  defp single_colon string do
    Regex.replace ~r/::/, string, ":"
  end
end

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
