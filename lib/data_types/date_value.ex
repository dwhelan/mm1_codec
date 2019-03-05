defmodule MMS.DateValue do
  use MMS.Codec
  alias MMS.Long

  def decode bytes do
    bytes
    |> decode_with(Long, &DateTime.from_unix/1)
  end

  def encode date_time = %DateTime{} do
    date_time
    |> encode_with(Long, &DateTime.to_unix/1)
  end
end
