defmodule MMS.ShortLength do
  use Codec2

  def decode(<<length, rest::binary>>) when is_short_length(length) and length <= byte_size(rest) do
    ok length, rest
  end

  def decode(bytes = <<length, _::binary>>) when is_short_length(length) do
    error code: :insufficient_bytes_for_short_length, bytes: bytes, value: length
  end

  def decode bytes = <<length, _::binary>> do
    error code: :invalid_short_length, bytes: bytes, value: length
  end

  def encode(value) when is_short_length(value) do
    ok <<value>>
  end

  def encode value do
    error code: :invalid_short_length, value: value
  end
end
