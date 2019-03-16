defmodule MMS.ShortLength do
  use MMS.Codec

  def decode(<<length, rest::binary>>) when is_short_length(length) and length <= byte_size(rest) do
    length
    |> decode_ok(rest)
  end

  def decode(bytes = <<length, rest::binary>>) when is_short_length(length) do
    bytes
    |> decode_error(%{short_length: length, available_bytes: byte_size(rest)})
  end

  def decode bytes = <<length, _::binary>> do
    bytes
    |> decode_error(%{out_of_range: length})
  end

  def encode(value) when is_short_length(value) do
    <<value>>
    |> ok
  end

  def encode(value) when is_integer(value) do
    value
    |> encode_error(:out_of_range)
  end
end
