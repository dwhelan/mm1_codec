defmodule MMS.Address do
  use MMS.Codec
  import CodecError

  alias MMS.EncodedStringValue
  alias MMS.{Either, IPv4Address, IPv6Address, PhoneNumber, EmailAddress, UnknownAddress}

  @types [PhoneNumber, EmailAddress, IPv4Address, IPv6Address, UnknownAddress]

  def decode bytes do
    bytes |> EncodedStringValue.decode <~> EncodedStringValue.map(&map/1)
  end

  defp map string do
    string |> Either.apply_until_ok(@types, :map)
  end

  def encode value do
    value|> unmap ~> EncodedStringValue.encode ~>> module_error()
  end

  defp unmap([charset, address]) when is_atom(charset) do
    address |> unmap ~> OldOkError.Tuple.insert_at({charset}, 0)
  end

  defp unmap address do
    address |> Either.apply_until_ok(@types, :unmap)
  end
end

defmodule MMS.Address2 do
  use MMS.Codec2

  def decode bytes do
    ok "email@address", ""
  end

  def encode address do
    ok "email@address\0"
  end
end
