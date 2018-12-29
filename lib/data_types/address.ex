defmodule MMS.Address do
  import MMS.OkError

  alias MMS.EncodedString
  alias MMS.Address.{IPv4, IPv6, PhoneNumber, Email, Unknown}

  def decode bytes do
    case_ok EncodedString.decode bytes do
      {value, rest} -> map value, rest
    end
  end

  defp map {string, charset}, rest do
    case_ok map string do
      address -> ok {address, charset}, rest
    end
  end

  defp map string, rest do
    case_ok map string do
      address -> ok address, rest
    end
  end

  defp map string do
    [value | type] = String.split string, "/TYPE=", parts: 2

    case type do
      ["IPv4"] -> IPv4.map value
      ["IPv6"] -> IPv6.map value
      ["PLMN"] -> PhoneNumber.map value
      []       -> Email.map string
      _        -> Unknown.map string
    end
  end

  def encode {address, charset} do
    EncodedString.encode {unmap(address), charset}
  end

  def encode address do
    EncodedString.encode unmap(address)
  end

  def encode _ do
    error :invalid_address
  end

  defp unmap address do
    type = cond do
      IPv4.is_ipv4? address                -> IPv4.unmap address
      IPv6.is_ipv6? address                -> IPv6.unmap address
      Email.is_email? address              -> Email.unmap address
      Unknown.is_unknown? address          -> Unknown.unmap address
      PhoneNumber.is_phone_number? address -> PhoneNumber.unmap address
    end
  end
end
