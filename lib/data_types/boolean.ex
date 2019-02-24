defmodule MMS.Boolean do
  use MMS.Codec2

  def decode <<128, rest::binary>> do
    true |> decode_ok(rest)
  end

  def decode <<129, rest::binary>> do
    false |> decode_ok(rest)
  end

  def decode bytes = <<value, _::binary>> do
    bytes |> decode_error(%{out_of_range: value})
  end

  def encode true do
    <<128>> |> ok
  end

  def encode false do
    <<129>> |> ok
  end
end
