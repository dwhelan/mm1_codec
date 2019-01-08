defmodule MMS.Address do
  use MMS.Codec
  import OkError.Module


  alias MMS.EncodedString
  alias MMS.{Either, IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress}

  @types [PhoneNumber, EmailAddress, IPv4Address, IPv6Address, UnknownAddress]

  def decode bytes do
    bytes |> EncodedString.decode <~> EncodedString.map(&map/1)
  end

  defp map string do
    string |> Either.apply_until_ok(@types, :map)
  end

  def encode value do
    value |> unmap ~> EncodedString.encode ~>> OkError.Module.module_error()
  end

  defp unmap({address, charset}) when is_atom(charset) do
    address |> unmap ~> OkError.Tuple.insert_at({charset}, 0)
  end

  defp unmap address do
    address |> Either.apply_until_ok(@types, :unmap)
  end
end
