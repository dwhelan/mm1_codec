defmodule MMS.Time do
  use MMS.Codec

  import MMS.Composer

  @absolute 0
  @relative 1

  @codecs [MMS.Short, MMS.Long]

  def decode(bytes), do: bytes |> decode(@codecs) <~> to_time

  defp to_time({seconds, @absolute}), do: seconds |> DateTime.from_unix!
  defp to_time({seconds, @relative}), do: seconds
  defp to_time(_),                    do: module_error()

  def encode(%DateTime{} = date_time), do: date_time |> DateTime.to_unix |> do_encode(@absolute)
  def encode(seconds),                 do: seconds |> do_encode(@relative)

  defp do_encode(seconds, absolute),  do: [absolute, seconds] |> encode(@codecs) ~>> module_error
end
