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
      ["IPv4"]  -> IPv4.map string
      ["IPv6"]  -> IPv6.map string
      ["PLMN"]  -> PhoneNumber.map value
      [_]       -> Unknown.map string
      []        -> Email.map value
    end
  end

  def encode({address, charset}) when is_atom(charset) do
    case_ok unmap address do
      string -> EncodedString.encode {string, charset}
    end
  end

  def encode address do
    case_ok unmap address do
      string -> EncodedString.encode string
    end
  end

  defp unmap address do
    unmap address, [IPv4, IPv6, PhoneNumber, Unknown, Email]
  end

  defp unmap address, [type | types] do
    case_error type.unmap address do
      _ -> unmap address, types
    end
  end

  defp unmap _, [] do
    error :invalid_address
  end
end
