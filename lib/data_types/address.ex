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

  alias MMS.EncodedStringValue

  def decode bytes do
    bytes
    |> EncodedStringValue.decode
    ~> fn {string, rest} -> string |> String.split("/TYPE=") |> do_decode(rest) end
  end

  defp do_decode [email], rest do
    ok email, rest
  end

  defp do_decode [phone_number, "PLMN"], rest do
    ok phone_number, rest
  end

  def encode address do
    address
    |> do_encode
    ~> fn string -> string |> EncodedStringValue.encode end
  end

  defp do_encode(string) when is_binary(string) do
    case string |> String.contains?("@") do
      true -> ok string
      false -> ok string <> "/TYPE=PLMN"
    end
  end
end
