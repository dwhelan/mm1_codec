defmodule MMS.Uint32 do
  use MMS.Codec2, error: :invalid_uint32

  use Bitwise

  def decode bytes = <<128, _::binary>> do
    error :invalid_uint32, bytes, :first_byte_cannot_be_128
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> do_decode([]) ~>> fn reason -> error :invalid_uint32, bytes, reason end
  end

  defp do_decode <<1::1, next::7, rest::binary>>, values do
    do_decode rest, [next | values]
  end

  defp do_decode <<last, rest::binary>>, values do
    sum([last |values]) |> ensure_uint32(rest)
  end

  defp sum values do
    values |> Enum.reverse |> Enum.reduce(& &1 + (&2 <<< 7))
  end

  defp ensure_uint32(value, rest) when is_uint32(value) do
    ok value, rest
  end

  defp ensure_uint32(_value, _rest) do
    error :out_of_range
  end

  def encode(value) when is_uint32(value) do
    ok do_encode shift7(value), encode_lsb7(value, 0)
  end

  def encode(value) when is_integer(value) do
    error :invalid_uint32, value, :out_of_range
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
