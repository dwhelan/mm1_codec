defmodule MMS.DateTime do
  use MMS.Codec2

  alias MMS.Long

  def decode bytes do
    bytes
    |> Long.decode
    ~> fn {long, rest} -> ok DateTime.from_unix(long), rest end
    ~>> fn details -> error :invalid_date_time, bytes, details end
  end

  def encode date_time = %DateTime{} do
    date_time
    |> DateTime.to_unix
    |> Long.encode
    ~>> fn details -> error :invalid_date_time, date_time, details end
  end
end
