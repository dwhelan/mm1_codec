defmodule MMS.DateTime do
  use MMS.Codec2

  alias MMS.Long

  def decode bytes do
    bytes
    |> Long.decode
    ~> fn {long, rest} -> ok DateTime.from_unix(long), rest end
    ~>> fn reason -> error :invalid_date_time, bytes, reason end
  end

  def encode date_time = %DateTime{} do
    date_time |> DateTime.to_unix |> Long.encode
  end

  def encode(_)  do
    {:error, __MODULE__}
  end
end
