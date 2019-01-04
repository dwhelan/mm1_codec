#defmodule MMS.Address do
#  use MMS.OneOf, codecs: [MMS.Mapper.IPv4Address, MMS.Mapper.IPv6Address, MMS.Mapper.PhoneNumber, MMS.Mapper.EmailAddress, MMS.Mapper.UnknownAddress]
#end

defmodule MMS.Address do
  use MMS.Codec

  alias MMS.EncodedString
  alias MMS.Mapper.{IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress}

  def decode bytes do
    bytes |> EncodedString.decode <~> EncodedString.map(&map_address/1)
  end

  defp map_address address do
    map_address address, [IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress]
  end

  defp map_address address, [type | types] do
    case_error type.map address do
      _ -> map_address address, types
    end
  end

  defp map_address _, [] do
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
