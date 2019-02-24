defmodule MMS.Boolean do
  use MMS.Codec2

  def decode <<128, rest::binary>> do
    true |> decode_ok(rest)
  end

  def decode <<129, rest::binary>> do
    false |> decode_ok(rest)
  end

  def decode bytes = <<value, _::binary>> do
    decode_error bytes, %{out_of_range: value}
  end

  def encode true do
    ok <<128>>
  end

  def encode false do
    ok <<129>>
  end
end
