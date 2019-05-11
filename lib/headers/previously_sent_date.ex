defmodule MMS.PreviouslySentDate do
  use MMS.Codec

  alias MMS.{ValueLengthList, IntegerValue, DateValue}

  def decode(bytes) do
    bytes
    |> ValueLengthList.decode([IntegerValue, DateValue])
    ~> fn {[count, date], rest} ->  {date, count} |> ok(rest) end
    ~>> fn {_, _, details} -> error bytes, details end
  end

  def encode({date = %DateTime{}, count}) when is_integer(count) do
    [count, date] |> ValueLengthList.encode([IntegerValue, DateValue])
    ~>> fn {_, _, details} -> error {date, count}, details end
  end

  def encode value do
    super value
  end
end
