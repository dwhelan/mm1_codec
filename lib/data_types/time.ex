defmodule MMS.Time do
  use MMS.Codec2

  import MMS.Composer

  @absolute 0
  @relative 1

  alias MMS.{ValueLengthList, Short, Long}
  @codecs [MMS.Short, MMS.Long, ValueLengthList]

#  def decode(bytes) do
#    bytes
#    |> decode(@codecs)
#    <~> to_time
#  end

  def decode(bytes) do
    bytes
    |> ValueLengthList.decode([&Short.decode/1, &Long.decode/1])
    ~> fn {result, rest} -> ok to_time(result), rest end
    ~>> fn details -> error bytes, details end
  end

  defp to_time([@absolute, seconds]) do
    seconds |> DateTime.from_unix!
  end

  defp to_time([@relative, seconds]) do
    seconds
  end

  defp to_time(_) do
    module_error()
  end

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
    |> ValueLengthList.encode([&Short.encode/1, &Long.encode/1])
  end
end
