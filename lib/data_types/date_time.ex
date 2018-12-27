defmodule MMS.DateTime do
  import MMS.OkError

  alias MMS.Long

  def decode bytes do
    case_ok Long.decode bytes do
      {seconds, rest} -> ok DateTime.from_unix!(seconds), rest
    end
  end

  def encode %DateTime{} = date_time do
    date_time |> DateTime.to_unix |> Long.encode
  end
end
