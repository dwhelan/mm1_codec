defmodule WAP.Uintvar do
  use MM1.BaseCodec
  use Bitwise

  def decode bytes do
    decode bytes, 0, <<>>
  end

  defp decode <<1::1, value::7, rest::binary>>, total, bytes do
    decode rest, add(value, total), bytes <> <<1::1, value::7>>
  end

  defp decode <<value, rest::binary>>, total, bytes do
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
