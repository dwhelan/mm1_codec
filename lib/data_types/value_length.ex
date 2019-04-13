defmodule MMS.ValueLength do
  @moduledoc """
  8.4.2.2 Length

  The following rules are used to encode length indicators.

  Value-length = Short-length | (Length-quote Length)

  Value length is used to indicate the length of the value to follow
  """
  use MMS.Codec
  import MMS.Prefix
  alias MMS.{ShortLength, UintvarInteger}

  def decode(bytes = <<short_length, _::binary>>) when is_short_length(short_length) do
    bytes
    |> decode_as(ShortLength)
  end

  def decode(bytes = <<length_quote, _::binary>>) when is_length_quote(length_quote) do
    bytes
    |> decode_with_prefix(UintvarInteger, length_quote())
    ~> fn {length, rest} ->
         if is_short_length(length) do
           decode_error bytes, :should_be_encoded_as_a_short_length
         else
           ok length, rest
         end
       end
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> decode_error(:does_not_start_with_a_short_length_or_length_quote)
  end

  def encode(value) when is_short_length(value) do
    value
    |> encode_as(ShortLength)
  end

  def encode(value) when is_integer(value) do
    value
    |> encode_with_prefix(UintvarInteger, length_quote())
  end

  def decode(bytes, codec) when is_binary(bytes) and is_atom(codec) do
    bytes
    |> decode(& codec.decode &1)
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
              ok value, rest
            else
              decode_error bytes, %{bytes_used: bytes_used, value_length: value_length, value: value}
            end
           end
       end
  end

  def encode(value, codec) when is_atom(codec) do
    value
    |> encode(& codec.encode &1)
  end

  def encode(value, encoder) when is_function(encoder) do
    value
    |> encoder.()
    ~> fn value_bytes ->
        value_bytes
        |> byte_size
        |> __MODULE__.encode
        ~> &(&1 <> value_bytes)
       end
  end
end
