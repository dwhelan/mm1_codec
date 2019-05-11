defmodule MMS.Time do
  @moduledoc """
  7.2.7 X-Mms-Delivery-Time field

  Delivery-time-value = Value-length (Absolute-token Date-value | Relative-token Delta-seconds-value)
  """
  use MMS.Codec

  @absolute 0
  @relative 1

  alias MMS.{ValueLengthList, ShortInteger, LongInteger}

  def decode(bytes) do
    bytes
    |> ValueLengthList.decode([ShortInteger, LongInteger])
    ~> fn {result, rest} ->
         result
         |> to_time
         |> ok(rest)
       end
    ~>> & error(bytes, &1)
  end

  defp to_time [@absolute, seconds] do
    seconds |> DateTime.from_unix!
  end

  defp to_time [@relative, seconds] do
    seconds
  end

  def encode value = %DateTime{} do
    value
    |> DateTime.to_unix
    |> do_encode(@absolute)
    ~>> & error(value, &1)
  end

  def encode(value) when is_long(value) do
    value
    |> do_encode(@relative)
    ~>> & error(value, &1)
  end

  def encode(value) when is_integer(value) do
    error value, :out_of_range
  end

  def encode value do
    super value
  end

  defp do_encode value, time_type do
    [time_type, value]
    |> ValueLengthList.encode([ShortInteger, LongInteger])
  end
end
