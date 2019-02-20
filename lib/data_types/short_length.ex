defmodule MMS.ShortLength do
  use MMS.Codec2

  def decode(<<length, rest::binary>>) when is_short_length(length) and length <= byte_size(rest) do
    ok length, rest
  end

  def decode(bytes = <<length, rest::binary>>) when is_short_length(length) do
    decode_error bytes, %{length: length, available_bytes: byte_size(rest)}
  end

  def decode bytes = <<length, _::binary>> do
    decode_error bytes, %{out_of_range: length}
  end

  def encode(value) when is_short_length(value) do
    ok <<value>>
  end

  def encode(value) when is_integer(value) do
    error value, :out_of_range
  end

  def prepend_length bytes do
    ok <<byte_size bytes>> <> bytes
  end
end
