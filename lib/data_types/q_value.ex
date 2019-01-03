defmodule MMS.QValue do
  use MMS.Codec

  alias MMS.Uint32

  def decode(bytes) when is_binary(bytes) do
    bytes |> Uint32.decode <~> q_string
  end

  defp q_string(value) when value <= 100 do
    :erlang.float_to_binary (value - 1) / 100, decimals: 2
  end

  defp q_string(value) when value <= 1099 do
    :erlang.float_to_binary (value - 100) / 1000, decimals: 3
  end

  defp q_string _ do
    error()
  end

  def encode(value) when is_binary(value) do
    value |> parse ~> unmap ~> Uint32.encode
  end

  defp parse string do
    case Float.parse string do
      {value, ""} -> ok { byte_size(string) - 2, Float.round(value, 3)}
      _           -> error()
    end
  end

  defp unmap({_, value}) when value >= 1.0 do
    error()
  end

  defp unmap({decimals, value}) when decimals <= 2 do
    round value * 100 + 1
  end

  defp unmap {_, value} do
    round value * 1000 + 100
  end

  defaults()
end
