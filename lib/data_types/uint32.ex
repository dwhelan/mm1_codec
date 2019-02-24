defmodule MMS.Uint32 do
  use MMS.Codec2, error: :uint32

  use Bitwise

  def decode bytes = <<128, _::binary>> do
    bytes |> decode_error(:first_byte_cannot_be_128)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> do_decode([])
    ~>> & decode_error bytes, &1
  end

  defp do_decode <<1::1, value::7, rest::binary>>, values do
    rest
    |> do_decode([value | values])
  end

  defp do_decode <<last, rest::binary>>, values do
    [last |values]
    |> sum
    |> ensure_uint32(rest)
  end

  defp sum values do
    values
    |> Enum.reverse
    |> Enum.reduce(& &1 + (&2 <<< 7))
  end

  defp ensure_uint32(value, rest) when is_uint32(value) do
    value |> decode_ok(rest)
  end

  defp ensure_uint32(value, _rest) do
    error %{out_of_range: value}
  end

  def encode(uint32) when is_uint32(uint32) do
    uint32 |> do_encode([]) |> ok
  end

  def encode(value) when is_integer(value) do
    value |> encode_error(:out_of_range)
  end

  defp do_encode value, [] do
    value >>> 7 |> do_encode([<<0::1, value::7>>])
  end

  defp do_encode 0, byte_list do
    byte_list |> Enum.join
  end

  defp do_encode value, byte_list do
    value >>> 7 |> do_encode([<<1::1, value::7>> | byte_list])
  end
end
