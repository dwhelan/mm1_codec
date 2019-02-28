defmodule MMS.From do
  use MMS.Codec2
  import Codec.Map

  alias MMS.From.FromAddress
  alias MMS.{ValueLength, Address, ShortInteger, ValueLengthList}

  @map %{
    0 => Address,
    1 => :insert_address_token,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> ValueLength.decode(& decode_map &1, ShortInteger, @map )
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
