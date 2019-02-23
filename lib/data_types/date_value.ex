defmodule MMS.DateValue do
  use MMS.Codec2
  import Codec.Map

  alias MMS.Long

  def decode bytes do
    bytes |> decode_map(Long, &DateTime.from_unix/1)
  end

  def encode date_time = %DateTime{} do
    date_time |> map_encode(&DateTime.to_unix/1, Long)
  end
end
