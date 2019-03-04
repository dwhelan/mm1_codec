defmodule MMS.PreviouslySentBy do
  use MMS.Codec

  alias MMS.{ValueLengthList, Integer, Address}

  def decode(bytes) do
    bytes
    |> ValueLengthList.decode([Integer, Address])
    ~> fn {[count, address], rest} ->  {address, count} |> decode_ok(rest) end
  end

  def encode({address, count}) when is_integer(count) do
    [count, address] |> ValueLengthList.encode([Integer, Address])
  end
end
