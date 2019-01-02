defmodule MMS.QValue do
  use MMS.Codec

  alias MMS.Uint32

  def decode(bytes) when is_binary(bytes) do
    bytes |> Uint32.decode ~> map
  end

  defp map {value, rest} do
    ok q_string(value), rest
  end

  defp q_string(value) when value <= 100 do
    q = (value - 1) / 100
    :erlang.float_to_binary q, decimals: 2
  end

  defp q_string value do
    q = (value - 100) / 1000
    :erlang.float_to_binary q, decimals: 3
  end

  def encode(value) when is_binary(value) do
    value |> unmap |> round |> Uint32.encode
  end

  defp unmap(string) when byte_size(string) <= 4 do
    :erlang.binary_to_float(string) * 100 + 1
  end

  defp unmap(string) do
    :erlang.binary_to_float(string) * 1000 + 100
  end

  defaults()
end
