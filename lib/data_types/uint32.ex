defmodule MMS.Uint32 do
  use Bitwise

  import MMS.OkError
  import MMS.DataTypes

  def decode bytes do
    decode bytes, 0, <<>>
  end

  defp decode<<1::1, value::7, rest::binary>>, total, bytes do
    decode rest, add(value, total), bytes <> <<1::1, value::7>>
  end

  defp decode(_, _, bytes) when byte_size(bytes) > 4 do
    error :uintvar_length_must_be_5_bytes_or_less
  end

  defp decode <<value, rest::binary>>, total, _ do
    ok add(value, total), rest
  end

  def encode(value) when is_uint32(value) do
    ok bytes_for(value >>> 7, <<value &&& 0x7f>>)
  end

  def encode _ do
    error :must_be_an_unsigned_32_bit_integer
  end

  defp bytes_for 0, bytes do
    bytes
  end

  defp bytes_for value, bytes do
    bytes_for value >>> 7, <<1::1, (value &&& 0x7f)::7>> <> bytes
  end

  defp add value, total do
    value + (total <<< 7)
  end
end
