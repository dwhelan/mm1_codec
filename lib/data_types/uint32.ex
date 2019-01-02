defmodule MMS.Uint32 do
  use MMS.Codec
  use Bitwise
  import Kernel, except: [+: 2]

  def decode(bytes) when is_binary(bytes) do
    do_decode bytes, 0, <<>>
  end

  defp do_decode<<1::1, value::7, rest::binary>>, total, bytes do
    do_decode rest, value + total, bytes <> <<1::1, value::7>>
  end

  defp do_decode(_, _, bytes) when byte_size(bytes) > 4 do
    error()
  end

  defp do_decode <<value, rest::binary>>, total, _ do
    ok value + total, rest
  end

  def encode(value) when is_uint32(value) do
    ok do_encode value >>> 7, <<byte(value)>>
  end

  defp do_encode 0, bytes do
    bytes
  end

  defp do_encode value, bytes do
    do_encode value >>> 7, <<1::1, byte(value)::7>> <> bytes
  end

  def byte value do
    value &&& 0x7f
  end

  def value + total do
    Kernel.+ value , total <<< 7
  end

  defaults()
end
