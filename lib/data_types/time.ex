defmodule MMS.AbsoluteTime do
  use MMS.Prefix, prefix: 128, codec: MMS.DateTime
end

defmodule MMS.RelativeTime do
  use MMS.Prefix, prefix: 129, codec: MMS.Long
end

defmodule MMS.EitherTime do
  use MMS.Either, [MMS.AbsoluteTime, MMS.RelativeTime]
end

defmodule MMS.Time do
#  use MMS.Composer, codecs: [MMS.EitherTime]
  use MMS.Codec

  import MMS.Composer

  @absolute 0
  @relative 1

  @codecs [MMS.Short, MMS.Long]

  def decode(bytes), do: bytes |> decode(@codecs) <~> to_time

  def encode(%DateTime{} = date_time), do: date_time |> DateTime.to_unix |> do_encode(@absolute)
  def encode(seconds),                 do: seconds |> do_encode(@relative)

  defp to_time({seconds, @absolute}), do: seconds |> DateTime.from_unix!
  defp to_time({seconds, @relative}), do: seconds
  defp to_time(_),                    do: error()

  defp do_encode(seconds, absolute),  do: [absolute, seconds] |> encode(@codecs) ~>> module_error
end
