defmodule MMS.Address do
  use MMS.Codec

  alias MMS.EncodedString
  alias MMS.{IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress}

  @types [PhoneNumber, EmailAddress, IPv4Address, IPv6Address, UnknownAddress]

  def decode bytes do
    bytes |> EncodedString.decode <~> EncodedString.map(&map/1)
  end

  defp map string do
    first_ok @types, & &1.map(string)
  end

  def encode value do
    value |> unmap ~> EncodedString.encode ~>> module_error()
  end

  defp unmap({address, charset}) when is_atom(charset) do
    address |> unmap ~> tuple(charset)
  end

  defp unmap address do
    first_ok @types, & &1.unmap(address)
  end
end
