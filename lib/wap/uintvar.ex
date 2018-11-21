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

  defp add value, total do
    (total <<< 7) + value
  end
end
