defmodule MMS.Time do
  @moduledoc """
  Delivery-time-value = Value-length (Absolute-token Date-value | Relative-token Delta-seconds-value)
  """
  use MMS.Codec2

  @absolute 0
  @relative 1

  alias MMS.{ValueLengthList, ShortInteger, Long}

  def decode(bytes) do
    bytes
    |> ValueLengthList.decode([ShortInteger, Long])
    ~> fn {result, rest} -> result |> to_time |> decode_ok(rest) end
    ~>> & bytes |> decode_error(&1)
  end

  defp to_time [@absolute, seconds] do
    seconds |> DateTime.from_unix!
  end

  defp to_time [@relative, seconds] do
    seconds
  end

  defp to_time(_) do
    module_error()
  end

  def encode date_time = %DateTime{} do
    date_time
    |> DateTime.to_unix
    |> do_encode(@absolute)
  end

  def encode(seconds) when is_long(seconds) do
    seconds
    |> do_encode(@relative)
  end

  defp do_encode seconds, time_type do
    [time_type, seconds]
    |> ValueLengthList.encode([ShortInteger, Long])
  end
end
