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
    ~>> fn details -> decode_error bytes, details end
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
    |> do_encode
    ~>> fn details -> error date_time, details end
  end

  def do_encode(seconds) when seconds >= 0 do
    seconds
    |> Long.encode
  end

  def do_encode _ do
    error :cannot_be_before_1970
  end
end
