defmodule MMS.ShortLength do
  use Codec2, error: :invalid_short_length

  def decode(<<length, rest::binary>>) when is_short_length(length) and length <= byte_size(rest) do
    ok length, rest
  end

  def decode(bytes = <<length, _::binary>>) when is_short_length(length) do
    error :invalid_short_length, bytes, {:insufficient_bytes, length}
  end

  def decode bytes = <<length, _::binary>> do
    error :invalid_short_length, bytes, length
  end

  def encode(value) when is_short_length(value) do
    ok <<value>>
  end

  def encode(value) when is_integer(value) do
    error :invalid_short_length, value
  end

  def prepend_length bytes do
    ok <<byte_size bytes>> <> bytes
  end
end
