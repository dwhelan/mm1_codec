defmodule MMS.From do
  use MMS.Codec2
  import Codec.Map

  alias MMS.{ValueLength, ShortInteger, Address}

  @map %{
    0 => Address,
    1 => :insert_address_token,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> ValueLength.decode(& decode_map &1, ShortInteger, @map )
  end

  def encode(from) do
    from
    |> ValueLength.encode(& map_encode &1, {@map, Address}, ShortInteger )
  end
end
