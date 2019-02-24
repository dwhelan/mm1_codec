defmodule MMS.PreviouslySentDate do
  use MMS.Codec2

  alias MMS.{ValueLengthList, Integer, DateValue}

  def decode(bytes) do
    bytes
    |> ValueLengthList.decode([Integer, DateValue])
    ~> fn {[count, date], rest} ->  {date, count} |> decode_ok(rest) end
  end

  def encode({date = %DateTime{}, count}) when is_integer(count) do
    [count, date] |> ValueLengthList.encode([Integer, DateValue])
  end
end
