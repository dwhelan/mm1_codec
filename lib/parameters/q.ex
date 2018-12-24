defmodule MMS.Q do
  use Bitwise

  alias MMS.Uint32

  import MMS.OkError
  import MMS.DataTypes

  def decode bytes do
    case_ok Uint32.decode bytes do
      {value, rest} -> ok map(value), rest
    end
  end

  defp map(value) when value <= 100 do
    q = (value - 1) / 100
    :erlang.float_to_binary q, decimals: 2
  end

  defp map value do
    q = (value - 100) / 1000
    :erlang.float_to_binary q, decimals: 3
  end

  def encode(value) when is_binary(value) do
    value |> unmap |> Uint32.encode
  end

  def encode _ do
    error :invalid_q_value
  end

  defp unmap(string) when byte_size(string) <= 4 do
    round(:erlang.binary_to_float(string) * 100 + 1)
  end

  defp unmap(string) do
    round(:erlang.binary_to_float(string) * 1000 + 100)
  end
end
