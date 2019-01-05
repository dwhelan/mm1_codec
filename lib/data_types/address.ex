defmodule MMS.Address do
  use MMS.Codec

  import MMS.OkError
  alias MMS.EncodedString
  alias MMS.Mapper.{IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress}

  @types [PhoneNumber, EmailAddress, IPv4Address, IPv6Address, UnknownAddress]

  def decode bytes do
    bytes |> EncodedString.decode <~> EncodedString.map(&map/1)
  end

  defp map string do
    while_error @types, & &1.map(string)
  end

  def encode value do
    value |> unmap ~> EncodedString.encode ~>> module_error()
  end

  defp unmap({address, charset}) when is_atom(charset) do
    address |> unmap ~> tuple(charset)
  end

  defp unmap address do
    while_error @types, & &1.unmap(address)
  end
end
