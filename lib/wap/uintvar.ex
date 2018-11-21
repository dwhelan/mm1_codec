defmodule WAP.Uintvar do
  use MM1.BaseCodec
  use Bitwise

  def decode(bytes) when is_binary(bytes) do
    decode bytes, 0, <<>>
  end

  defp decode(<<byte, rest::binary>>, value, bytes) when byte >= 128 do
    decode rest, add(byte-128, value), bytes <> <<byte>>
  end

  defp decode <<byte, rest::binary>>, value, bytes do
    value add(byte, value), bytes <> <<byte>>, rest
  end

  defp add byte, value do
    (value <<< 7) + byte
  end
end
