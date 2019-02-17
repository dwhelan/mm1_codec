defmodule MMS.Time do
  use MMS.Codec

  import MMS.Composer

  @absolute 0
  @relative 1

  alias MMS.{ValueLengthList}
  @codecs [MMS.Short, MMS.Long, ValueLengthList]

  def decode(bytes), do: bytes |> decode(@codecs) <~> to_time

  defp to_time({seconds, @absolute}), do: seconds |> DateTime.from_unix!
  defp to_time({seconds, @relative}), do: seconds
  defp to_time(_),                    do: module_error()

#  defp do_encode(seconds, absolute),  do: [absolute, seconds] |> encode(@codecs) ~>> module_error

  def decode(bytes) when is_binary(bytes) do
    error :invalid_short
  end

  def encode(%DateTime{} = date_time) do
    date_time
    |> DateTime.to_unix
    |> do_encode(@absolute)
  end

  def encode seconds do
    seconds
    |> do_encode(@relative)
  end

  defp do_encode seconds, time_type do
    [time_type, seconds]
    |> ValueLengthList.encode([&MMS.Short.encode/1, &MMS.Long.encode/1])
  end
end
