defmodule MMS.DateValue do
  use MMS.Codec2

  alias MMS.Long

  def decode bytes do
    bytes
    |> Long.decode
    ~> fn {seconds, rest} ->
        seconds
        |> DateTime.from_unix
        ~> fn date_time -> ok date_time, rest end
       end
    ~>> fn details -> decode_error bytes, details end
  end

  def encode date_time = %DateTime{} do
    date_time
    |> DateTime.to_unix
    |> do_encode
    ~>> fn details -> encode_error date_time, details end  end

  def do_encode(seconds) when seconds >= 0 do
    seconds
    |> Long.encode
  end

  def do_encode _ do
    error :cannot_be_before_1970
  end
end
