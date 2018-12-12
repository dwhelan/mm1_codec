defmodule WAP.Uintvar do
  use MM1.Codecs.Base
  use Bitwise

  def decode bytes do
    _decode bytes, 0, <<>>
  end

  defp _decode<<1::1, value::7, rest::binary>>, total, bytes do
    _decode rest, add(value, total), bytes <> <<1::1, value::7>>
  end

  defp _decode(<<value, rest::binary>>, total, bytes) when byte_size(bytes) > 4 do
    decode_error :uintvar_length_must_be_5_bytes_or_less, add(value, total), bytes <> <<value>>, rest
  end

  defp _decode <<value, rest::binary>>, total, bytes do
    decode_ok add(value, total), bytes <> <<value>>, rest
  end

  def new(value) when is_uintvar(value) do
    new_ok value, bytes_for(value >>> 7, <<value &&& 0x7f>>)
  end

  def new value do
    new_error :must_be_an_unsigned_32_bit_integer, value
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

defmodule WAP2.Uintvar do
  use Bitwise

  import MM1.OkError
  import WAP.Guards

  def decode bytes do
    _decode bytes, 0, <<>>
  end

  defp _decode<<1::1, value::7, rest::binary>>, total, bytes do
    _decode rest, add(value, total), bytes <> <<1::1, value::7>>
  end

  defp _decode(<<value, rest::binary>>, total, bytes) when byte_size(bytes) > 4 do
    error :uintvar_length_must_be_5_bytes_or_less
  end

  defp _decode <<value, rest::binary>>, total, bytes do
    ok {add(value, total), rest}
  end

  def encode(value) when is_uintvar(value) do
    ok bytes_for(value >>> 7, <<value &&& 0x7f>>)
  end

  def encode value do
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
