defmodule MMS.Uint32 do
  use MMS.Codec
  import OkError.Module

  use Bitwise

  def decode<<128, _::binary>> do
    module_error()
  end

  def decode(bytes) when is_binary(bytes) do
    do_decode bytes, []
  end

  defp do_decode<<1::1, next::7, rest::binary>>, values do
    do_decode rest, [next | values]
  end

  defp do_decode <<last, rest::binary>>, values do
    sum([last |values]) |> ensure_uint32 ~> ok(rest)
  end

  defp sum values do
    values |> Enum.reverse |> Enum.reduce(& &1 + (&2 <<< 7))
  end

  defp ensure_uint32 value do
    if is_uint32(value), do: value, else: module_error()
  end

  def encode(value) when is_uint32(value) do
    ok do_encode shift7(value), encode_lsb7(value, 0)
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

  defaults()
end
