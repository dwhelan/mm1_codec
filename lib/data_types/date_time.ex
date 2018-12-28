defmodule MMS.DateTime do
  import MMS.OkError

  alias MMS.Long

  def decode bytes do
    case_ok Long.decode bytes do
      {seconds, rest} -> ok DateTime.from_unix!(seconds), rest
    end
  end

  def encode %DateTime{} = date_time do
    date_time |> DateTime.to_unix |> encode
  end

  def encode(seconds) when seconds >= 0  do
    Long.encode seconds
  end

  def encode _  do
    error :invalid_date_time
  end
end
