defmodule MMS.Uint32 do
  use MMS.Codec2, error: :uint32

  use Bitwise

  def decode bytes = <<128, _::binary>> do
    bytes
    |> decode_error(:first_byte_cannot_be_128)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> do_decode([])
    ~>> fn details -> decode_error bytes, details end
  end

  defp do_decode <<1::1, next::7, rest::binary>>, values do
    rest
    |> do_decode([next | values])
  end

  defp do_decode <<last, rest::binary>>, values do
    sum([last |values])
    |> ensure_uint32(rest)
  end

  defp sum values do
    values
    |> Enum.reverse
    |> Enum.reduce(& &1 + (&2 <<< 7))
  end

  defp ensure_uint32(value, rest) when is_uint32(value) do
    ok value, rest
  end

  defp ensure_uint32(value, _rest) do
    error %{out_of_range: value}
  end

  def encode(value) when is_uint32(value) do
    value
    |> shift7
    |> do_encode(value |> encode_lsb7(0))
    |> ok
  end

  def encode(value) when is_integer(value) do
    encode_error value, :out_of_range
  end

  defp do_encode 0, bytes do
    bytes
  end

  defp do_encode value, bytes do
    do_encode shift7(value), encode_lsb7(value, 1) <> bytes
  end

  defp encode_lsb7 value, continue do
    <<continue::1, (value &&& 0x7f)::7>>
  end

  defp shift7 value do
    value >>> 7
  end
end
