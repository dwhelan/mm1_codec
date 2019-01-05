#defmodule MMS.Address do
#  use MMS.OneOf, codecs: [MMS.Mapper.IPv4Address, MMS.Mapper.IPv6Address, MMS.Mapper.PhoneNumber, MMS.Mapper.EmailAddress, MMS.Mapper.UnknownAddress]
#end

defmodule MMS.Address do
  use MMS.Codec

  alias MMS.OkError
  alias MMS.EncodedString
  alias MMS.Mapper.{IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress}

  @types [PhoneNumber, EmailAddress, IPv4Address, IPv6Address, UnknownAddress]

  def decode bytes do
    bytes |> EncodedString.decode <~> EncodedString.map(&map/1)
  end

  defp map string do
    OkError.while_error(@types, & &1.map(string))
  end

  def encode({address, charset}) when is_atom(charset) do
    case_ok unmap address do
      string -> EncodedString.encode {string, charset}
    end
  end

  def encode address do
    address |> unmap ~> EncodedString.encode ~>> module_error()
  end

  defp unmap address do
    OkError.while_error(@types, & &1.unmap(address))
  end
end
