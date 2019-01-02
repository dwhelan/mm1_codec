defmodule MMS.QValue do
  use MMS.Codec

  alias MMS.Uint32

  def decode(bytes) when is_binary(bytes) do
    bytes |> Uint32.decode |> map_value(q_string)
  end

  defp q_string(value) when value <= 100 do
    format (value - 1) / 100, 2
  end

  defp q_string(value) when value <= 1099 do
    format (value - 100) / 1000, 3
  end

  defp q_string _ do
    error()
  end

  defp format float, decimals do
    ok :erlang.float_to_binary(float, decimals: decimals)
  end

  def encode(value) when is_binary(value) do
    value |> parse ~> unmap ~> Uint32.encode
  end

  defp parse string do
    case Float.parse string do
      {value, ""} -> ok {string, Float.round(value, 3)}
      _           -> error()
    end
  end

  defp unmap({_, value}) when value >= 1.0 do
    error()
  end

  defp unmap({string, value}) when byte_size(string) <= 4 do
    round value * 100 + 1
  end

  defp unmap({_, value}) do
    round value * 1000 + 100
  end

  defaults()
end
