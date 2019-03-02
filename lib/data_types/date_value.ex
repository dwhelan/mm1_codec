defmodule MMS.DateValue do
  use MMS.Codec2
  import Codec.Map

  alias MMS.Long

  def decode bytes do
    bytes |> decode(Long, &DateTime.from_unix/1)
  end

  def encode date_time = %DateTime{} do
    date_time |> encode(Long, &DateTime.to_unix/1)
  end
end
