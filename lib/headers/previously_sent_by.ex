defmodule MMS.PreviouslySentBy do
  use MMS.Codec

  alias MMS.{ValueLengthList, IntegerValue, Address}

  def decode(bytes) do
    bytes
    |> ValueLengthList.decode([IntegerValue, Address])
    ~> fn {[count, address], rest} ->  {address, count} |> ok(rest) end
    ~>> fn {_, _, details} -> error bytes, details end
  end

  def encode({address, count}) when is_integer(count) do
    [count, address]
    |>ValueLengthList.encode([IntegerValue, Address])
    ~>> fn {_, _, details} -> error {address, count}, details end
  end

  def encode value do
    super value
  end
end
