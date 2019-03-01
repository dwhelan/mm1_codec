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
    |> ValueLength.decode(
         fn value_bytes -> value_bytes |> decode_map(ShortInteger, @map) end
       )
  end

  def encode(from) when is_address(from) or from == :insert_address_token do
    from
    |> ValueLength.encode(
         fn value -> value |> map_encode(ShortInteger, @map, Address) end
       )
  end
end
