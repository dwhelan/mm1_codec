#defmodule MMS.Address do
#  use MMS.OneOf, codecs: [MMS.Mapper.IPv4Address, MMS.Mapper.IPv6Address, MMS.Mapper.PhoneNumber, MMS.Mapper.EmailAddress, MMS.Mapper.UnknownAddress]
#end

defmodule MMS.Address do
  use MMS.Codec

  alias MMS.OkError
  alias MMS.EncodedString
  alias MMS.Mapper.{IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress}

  @addresses [PhoneNumber, EmailAddress, IPv4Address, IPv6Address, UnknownAddress]

  def decode bytes do
    bytes |> EncodedString.decode <~> EncodedString.map(&map/1)
  end

  defp map string do
    @addresses |> OkError.while_error(& &1.map(string))
  end

  def encode({address, charset}) when is_atom(charset) do
#    address |> unmap ~> EncodedString.encode(charset)
    case_ok unmap address do
      string -> EncodedString.encode {string, charset}
    end
  end

  def encode address do
    address |> unmap ~> EncodedString.encode
  end

  defp unmap address do
    unmap address, [PhoneNumber, EmailAddress, IPv4Address, IPv6Address, UnknownAddress]
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
