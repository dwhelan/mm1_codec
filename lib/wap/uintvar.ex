defmodule WAP.Uintvar do
  use MM1.BaseCodec
  use Bitwise

  def decode bytes do
    _decode bytes, 0, <<>>
  end

  defp _decode<<1::1, value::7, rest::binary>>, total, bytes do
    _decode rest, add(value, total), bytes <> <<1::1, value::7>>
  end

  defp _decode(<<value, rest::binary>>, _total, bytes) when byte_size(bytes) > 4 do
    error :must_be_5_bytes_or_less, bytes <> <<value>>, bytes <> <<value>>, rest
  end

  defp _decode <<value, rest::binary>>, total, bytes do
    value add(value, total), bytes <> <<value>>, rest
  end

  def new value do
    value value, bytes_for(value >>> 7, <<value &&& 0x7f>>)
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
