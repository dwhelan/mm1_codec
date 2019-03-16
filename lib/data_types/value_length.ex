defmodule MMS.Prefix do
  use MMS.Codec

  defmacro encode_with_prefix value, codec, prefix do
    data_type = data_type( __CALLER__.module)
    quote do
      Kernel.apply(unquote(codec), :encode, [unquote(value)])
      ~> fn bytes -> <<unquote(prefix)>> <> bytes end
      ~>> fn details -> error unquote(data_type), unquote(value), nest_error(details) end
    end
  end
end

defmodule MMS.ValueLength do
  use MMS.Codec
  import MMS.Prefix
  alias MMS.{ShortLength, Length, Uint32}

  def decode(bytes = <<short_length, _::binary>>) when is_short_length(short_length) do
    bytes
    |> decode_as(ShortLength)
  end

  def decode(bytes = <<length_quote, rest::binary>>) when is_length_quote(length_quote) do
    rest
    |> decode_as(Uint32)
    ~>> fn details -> decode_error bytes, details end
    ~> fn {length, rest} ->
         if is_short_length(length) do
           decode_error bytes, :should_be_encoded_as_a_short_length
         else
           decode_ok length, rest
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
    |> encode_with_prefix(Uint32, length_quote())
  end

#  def encode_with_prefix value, codec, prefix do
#    value
#    |> encode_as(codec)
#    ~> fn bytes -> <<prefix>> <> bytes end
#    ~>> fn details ->  encode_error value, details end
#  end

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
