defmodule MMS.ValueLength do
  use MMS.Codec2, error: :value_length

  alias MMS.{ShortLength, Length}

  def decode(bytes = <<short_length, _::binary>>) when is_short_length(short_length) do
    bytes |> ShortLength.decode
  end

  def decode bytes = <<31, _::binary>> do
    bytes
    |> Length.decode
    ~> ensure_minimal_encoding
    ~>> fn details -> error bytes, details end
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :does_not_start_with_a_short_length_or_length_quote
  end

  defp ensure_minimal_encoding({length, _rest}) when is_short_length(length) do
    error :should_be_encoded_as_a_short_length
  end

  defp ensure_minimal_encoding {length, rest} do
    ok length, rest
  end

  def encode(value) when is_short_length(value) do
    value |> encode(ShortLength)
  end

  def encode(value) when is_integer(value) do
    value |> encode(Length)
  end

  defp encode(value, codec) do
    value
    |> codec.encode
    ~>> fn details -> error value, details end
  end
end
