defmodule MMS.PreviouslySentDate do
  use MMS.Codec

  alias MMS.{ValueLengthList, IntegerValue, DateValue}

  def decode(bytes) do
    bytes
    |> ValueLengthList.decode([IntegerValue, DateValue])
    ~> fn {[count, date], rest} ->  {date, count} |> ok(rest) end
  end

  def encode({date = %DateTime{}, count}) when is_integer(count) do
    [count, date] |> ValueLengthList.encode([IntegerValue, DateValue])
  end
end
