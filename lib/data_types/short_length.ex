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

  def encode value do
    error :invalid_short_length, value
  end

  defmodule Encode do
    def prepend bytes do
      ok <<byte_size bytes>> <> bytes
    end
  end
end
