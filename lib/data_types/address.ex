#defmodule MMS.Address do
#  use MMS.OneOf, codecs: [MMS.Mapper.IPv4Address, MMS.Mapper.IPv6Address, MMS.Mapper.PhoneNumber, MMS.Mapper.EmailAddress, MMS.Mapper.UnknownAddress]
#end

defmodule MMS.Address do
  import MMS.OkError

  alias MMS.EncodedString
  alias MMS.Mapper.{IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress}

  def decode bytes do
    case_ok EncodedString.decode bytes do
      {value, rest} -> map value, rest
    end
  end

  defp map address, rest do
    address |> EncodedString.map(&map1/1) ~> ok(rest)
  end

  defp map1 address do
    map1 address, [IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress]
  end

  defp map1 address, [type | types] do
    case_error type.map address do
      _ -> map1 address, types
    end
  end

  defp map1 _, [] do
    error :invalid_address
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
    unmap address, [IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress]
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
