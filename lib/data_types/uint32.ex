defmodule MMS.Uint32 do
  use MMS.Codec
  use Bitwise

  def decode(bytes) when is_binary(bytes) do
    do_decode bytes, 0, 0
  end

  defp do_decode<<1::1, value::7, rest::binary>>, total, size do
    do_decode rest, add(value, total), size+1
  end

  defp do_decode(_, _, size) when size > 4 do
    IO.inspect size2: size
    error()
  end

  defp do_decode <<value, rest::binary>>, total, _size do
    ok add(value, total), rest
  end

  def encode(value) when is_uint32(value) do
    ok do_encode value |> shift7, value |> encode_lsb7(0)
  end

  defp do_encode 0, bytes do
    bytes
  end

  defp do_encode value, bytes do
    do_encode value |> shift7, (value |> encode_lsb7(1)) <> bytes
  end

  defp encode_lsb7 value, continue do
    <<continue::1, (value &&& 0x7f)::7>>
  end

  defp add value, total do
    value + (total <<< 7)
  end

  def shift7 value do
    value >>> 7
  end

  defaults()
end
