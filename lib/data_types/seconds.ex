defmodule MMS.Seconds do
  use MMS.Codec

  import MMS.Composer

  @absolute 0
  @relative 1

  @codecs [MMS.Short, MMS.Long]

  def decode(bytes), do: bytes |> decode(@codecs) <~> to_seconds

  def encode(%DateTime{} = date_time), do: date_time |> DateTime.to_unix |> from_seconds(@absolute)
  def encode(seconds),                 do: seconds |> from_seconds(@relative)

  defp to_seconds({seconds, @absolute}), do: seconds |> DateTime.from_unix!
  defp to_seconds({seconds, @relative}), do: seconds
  defp to_seconds(_),                    do: error()

  defp from_seconds(seconds, absolute),  do: [absolute, seconds] |> encode(@codecs) ~>> module_error
end
