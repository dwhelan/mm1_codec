defmodule MMS.DateValue do
  use MMS.Codec2

  alias MMS.Long

  def decode bytes do
    bytes
    |> Long.decode
    ~> fn {value, rest} ->
        value
        |> DateTime.from_unix
        |> check_date_time(rest)
       end
    ~>> fn details -> error bytes, details end
  end

  defp check_date_time {:ok, date_time}, rest do
    ok date_time, rest
  end

  defp check_date_time {:error, reason}, _rest do
    error reason
  end

  def encode date_time = %DateTime{} do
    date_time
    |> DateTime.to_unix
    |> Long.encode
    ~>> fn details -> error date_time, details end
  end
end
