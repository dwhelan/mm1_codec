defmodule QValue do
  defmodule Decode do
    use Codec.Decode

    alias MMS.Uint32
    import Operators

    def decode bytes do
      bytes |> Uint32.decode ~> fn result -> to_q_string(result, bytes) end
    end

    defp to_q_string({value, rest}, _bytes) when value > 0 and value <= 100 do
      ok (value - 1) |> format(2), rest
    end

    defp to_q_string({value, rest}, _bytes) when value > 100 and value <= 1099 do
      ok (value - 100) |> format(3), rest
    end

    defp to_q_string {value, _rest}, bytes do
      error :invalid_q_value, bytes, value
    end

    defp format value, digits do
      value |> Integer.to_string |> String.pad_leading(digits, "0")
    end
  end

  defmodule Encode do
    use Codec.Encode

    alias MMS.Uint32
    import Operators

    def encode(string) when is_binary(string) do
      string |> Float.parse |> to_q_value |> bind(fn q_value -> to_uint32(q_value, string) end) ~> Uint32.encode |> bind_error(fn error -> error :invalid_q_value, string end)
    end

    defp to_q_value {value, ""} do
        ok value
    end

    defp to_q_value _ do
      error :invalid_q_value
    end

    defp to_uint32(q_value, string) when q_value >= 1.0 do
      error :invalid_q_value, q_value
    end

    defp to_uint32(q_value, string) when byte_size(string) <= 4 do
      ok round q_value * 100 + 1
    end

    defp to_uint32 q_value, _ do
      ok round q_value * 1000 + 100
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
