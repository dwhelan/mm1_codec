defmodule MMS.PreviouslySentBy do
  use MMS.Codec

  alias MMS.{ValueLengthList, IntegerValue, Address}

  def decode(bytes) do
    bytes
    |> ValueLengthList.decode([IntegerValue, Address])
    ~> fn {[count, address], rest} ->  {address, count} |> ok(rest) end
  end

  def encode({address, count}) when is_integer(count) do
    [count, address] |> ValueLengthList.encode([IntegerValue, Address])
  end
end
