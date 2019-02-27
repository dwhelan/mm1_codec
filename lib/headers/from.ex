defmodule MMS.From do
  use MMS.Codec2

  alias MMS.From.FromAddress
  alias MMS.{ValueLengthList}

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> ValueLengthList.decode([FromAddress])
    ~> fn {[address], rest} -> decode_ok address, rest end
    ~>> & bytes |> decode_error(&1)
  end

  def encode(from) do
    [from]
    |> ValueLengthList.encode([FromAddress])
    ~>> & from |> encode_error(&1)
  end

  defmodule FromAddress do
    use MMS.Codec2

    import Codec.Map

    alias MMS.{Address, ShortInteger}

    @map %{
      0 => Address,
      1 => :insert_address_token,
    }

    def decode bytes do
      bytes |> decode_map(ShortInteger, @map)
    end

    def encode address do
      address |> map_encode({@map, Address}, ShortInteger)
    end
  end
end

defmodule MMS.From.Old do
  use MMS.Codec

  alias MMS.{Composer, ShortInteger, Address}

  @address_present_token 0
  @insert_address_token  1

  def decode bytes do
    bytes |> Composer.decode([ShortInteger, Address]) <~> address
  end

  defp address({address, @address_present_token}), do: address
  defp address({@insert_address_token}),           do: :insert_address_token
  defp address(_),                                 do: module_error()

  def encode :insert_address_token do
    ok <<1, @insert_address_token + 128>>
  end

  def encode string do
    [@address_present_token, string] |> Composer.encode([ShortInteger, Address]) ~>> module_error
  end
end
