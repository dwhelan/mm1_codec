defmodule MMS.QValue do
  use MMS.Codec2, error: :invalid_q_value

  alias MMS.Uint32

  def decode bytes do
    bytes
    |> Uint32.decode
    ~>> fn error -> error :invalid_q_value, bytes, error end
    ~> fn result -> to_q_string(result, bytes) end
  end

  defp to_q_string({q_value, rest}, _bytes) when q_value > 0 and q_value <= 100 do
    ok (q_value - 1) |> format(2), rest
  end

  defp to_q_string({q_value, rest}, _bytes) when q_value > 100 and q_value < 1100 do
    ok (q_value - 100) |> format(3), rest
  end

  defp to_q_string {q_value, _rest}, bytes do
    error :invalid_q_value, bytes, out_of_range: q_value
  end

  defp format q_value, digits do
    q_value |> Integer.to_string |> String.pad_leading(digits, "0")
  end

  def encode(string) when is_binary(string) do
    string
    |> Integer.parse
    |> pure
    ~> fn integer -> to_q_value integer, byte_size string end
    ~> Uint32.encode
    ~>> fn _ -> error :invalid_q_value, string, :must_be_string_of_2_or_3_digits end
  end

  defp pure({integer, ""}), do: ok integer
  defp pure(_),             do: error nil

  defp to_q_value(integer, 2), do: ok integer + 1
  defp to_q_value(integer, 3), do: ok integer + 100
  defp to_q_value(_ , _),      do: error nil
end
