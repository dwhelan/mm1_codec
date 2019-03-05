defmodule MMS.ValueLength do
  use MMS.Codec
  alias MMS.{ShortLength, Length}

  def decode(bytes = <<short_length, _::binary>>) when is_short_length(short_length) do
    bytes
    |> ShortLength.decode
    ~>> fn {_, _, reason} -> error bytes, reason end
  end

  def decode(bytes = <<length_quote, _::binary>>) when is_length_quote(length_quote) do
    bytes |> decode(Length, &ensure_minimal_encoding/1)
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

  def decode(bytes, codec) when is_binary(bytes) and is_atom(codec) do
    bytes |>  __MODULE__.decode(& codec.encode &1)
  end

  def decode(bytes, f) when is_binary(bytes) and is_function(f) do
    bytes
    |>  __MODULE__.decode
    ~> fn {value_length, value_bytes} ->
        value_bytes
        |> f.()
        ~>> fn {data_type, _, reason} -> error data_type, bytes, reason end
        ~> fn {value, rest} ->
            bytes_used = byte_size(value_bytes) - byte_size(rest)
            if bytes_used == value_length do
              decode_ok value, rest
            else
              error bytes, %{bytes_used: bytes_used, value_length: value_length, value: value}
            end
           end
       end
  end

  def encode(value) when is_short_length(value) do
    value |> encode_with(ShortLength)
  end

  def encode(value) when is_integer(value) do
    value |> encode_with(Length)
  end

  def encode(value, codec) when is_atom(codec) do
    value |> encode(& codec.encode &1)
  end

  def encode(value, f) when is_function(f) do
    value
    |> f.()
    ~> fn value_bytes ->
        value_bytes
        |> byte_size
        |> __MODULE__.encode
        ~> &(&1 <> value_bytes)
       end
  end
end
