defmodule QValue do
  defmodule Decode do
    use Codec.Decode

    def decode bytes do
      bytes |> MMS.Uint32.decode ~> fn result -> to_q_string(result, bytes) end
    end

    defp to_q_string({q_value, rest}, _bytes) when q_value > 0 and q_value <= 100 do
      ok (q_value - 1) |> format(2), rest
    end

    defp to_q_string({q_value, rest}, _bytes) when q_value > 100 and q_value < 1100 do
      ok (q_value - 100) |> format(3), rest
    end

    defp to_q_string {q_value, _rest}, bytes do
      error :invalid_q_value, bytes, q_value
    end

    defp format q_value, digits do
      q_value |> Integer.to_string |> String.pad_leading(digits, "0")
    end
  end

  defmodule Encode do
    use Codec.Encode

    def encode(string) when is_binary(string) do
      string
      |> Integer.parse
      |> to_ok_error
      ~> fn integer -> to_q_value integer, byte_size string end
      ~> MMS.Uint32.encode
      ~>> fn _ -> error :invalid_q_value, string end
    end

    defp to_ok_error {integer, ""} do
      ok integer
    end

    defp to_ok_error _ do
      error()
    end

    defp to_q_value integer, 2 do
      ok integer + 1
    end

    defp to_q_value integer, 3 do
      ok integer + 100
    end

    defp to_q_value _ , _ do
      error()
    end
  end
end

defmodule MMS.QValue do
  use MMS.Codec
  import CodecError

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
    module_error()
  end

  def encode(value) when is_binary(value) do
    value |> parse ~> unmap ~> Uint32.encode
  end

  defp parse string do
    case Float.parse string do
      {value, ""} -> ok { byte_size(string) - 2, Float.round(value, 3)}
      _           -> module_error()
    end
  end

  defp unmap({_, value}) when value >= 1.0 do
    module_error()
  end

  defp unmap({decimals, value}) when decimals <= 2 do
    round value * 100 + 1
  end

  defp unmap {_, value} do
    round value * 1000 + 100
  end

  defaults()
end
