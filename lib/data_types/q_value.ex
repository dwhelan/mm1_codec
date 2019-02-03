defmodule MMS.QValue do
  use Codec2, error: :invalid_q_value

  def decode bytes do
    bytes
    |> MMS.Uint32.decode
    ~>> fn error -> error code: :invalid_q_value, bytes: bytes, nested: error end
    ~> fn result -> to_q_string(result, bytes) end
  end

  defp to_q_string({q_value, rest}, _bytes) when q_value > 0 and q_value <= 100 do
    ok (q_value - 1) |> format(2), rest
  end

  defp to_q_string({q_value, rest}, _bytes) when q_value > 100 and q_value < 1100 do
    ok (q_value - 100) |> format(3), rest
  end

  defp to_q_string {q_value, _rest}, bytes do
    error code: :invalid_q_value, bytes: bytes, value: q_value
  end

  defp format q_value, digits do
    q_value |> Integer.to_string |> String.pad_leading(digits, "0")
  end

  def encode(string) when is_binary(string) do
    string
    |> Integer.parse
    |> to_ok_error
    ~> fn integer -> to_q_value integer, byte_size string end
    ~> MMS.Uint32.encode
    ~>> fn _ -> error code: :invalid_q_value, value: string end
  end

  defp to_ok_error({integer, ""}), do: ok integer
  defp to_ok_error(_),             do: OkError.error :invalid_q_value

  defp to_q_value(integer, 2),     do: ok integer + 1
  defp to_q_value(integer, 3),     do: ok integer + 100
  defp to_q_value(_int , _digits), do: OkError.error nil
end
