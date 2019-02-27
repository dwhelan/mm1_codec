defmodule MMS.ValueLength do
  use MMS.Codec2
  import Codec.Map

  alias MMS.{ShortLength, Length}

  def decode(bytes = <<short_length, _::binary>>) when is_short_length(short_length) do
    bytes |> ShortLength.decode
  end

  def decode bytes = <<31, _::binary>> do
    bytes |> decode_map(Length, &ensure_minimal_encoding/1)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_error(:does_not_start_with_a_short_length_or_length_quote)
  end

  defp ensure_minimal_encoding(length) when is_short_length(length) do
    :should_be_encoded_as_a_short_length |> error
  end

  defp ensure_minimal_encoding length do
    length |> ok
  end

  def decode(bytes, codec) when is_binary(bytes) do
    bytes
    |>  __MODULE__.decode
    ~> fn {_length, rest} ->
        rest
        |> codec.decode
        ~>> fn {data_type, _, reason} -> error data_type, bytes, reason end
       end
  end

  def encode(value) when is_short_length(value) do
    value |> encode_with(ShortLength)
  end

  def encode(value) when is_integer(value) do
    value |> encode_with(Length)
  end
end
