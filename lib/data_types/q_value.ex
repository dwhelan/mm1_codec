defmodule MMS.QValue do
  use MMS.Codec

  alias MMS.Uint32

  def decode(bytes) when is_binary(bytes) do
    bytes |> Uint32.decode ~> map ~>> module_error
  end

  defp map({value, rest}) when value <= 100 do
    ok q_string((value - 1) / 100, 2), rest
  end

  defp map({value, rest}) when value <= 1099 do
    ok q_string((value - 100) / 1000, 3), rest
  end

  defp map _ do
    error()
  end

  defp q_string value, decimals do
    :erlang.float_to_binary(value, decimals: decimals)
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
