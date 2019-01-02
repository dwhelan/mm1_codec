defmodule MMS.Uint32 do
  use MMS.Codec
  use Bitwise

  def decode(bytes) when is_binary(bytes) do
    do_decode bytes, []
  end

  defp do_decode<<1::1, value::7, rest::binary>>, values do
    do_decode rest, [value | values]
  end

  defp do_decode <<value, rest::binary>>, values do
    ok_if_uint32 value |> total(values), rest
  end

  defp total value, values do
    [value | values] |> Enum.reverse |> Enum.reduce(& &1 + (&2 <<< 7))
  end

  defp ok_if_uint32(value, rest) when is_uint32(value) do
    ok value, rest
  end

  defp ok_if_uint32 _, _ do
    error()
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

  defp shift7 value do
    value >>> 7
  end

  defaults()
end
