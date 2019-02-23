defmodule MMS.QValue do
  use MMS.Codec2, error: :q_value

  alias MMS.Uint32
  import Codec.Map

  def decode bytes do
    bytes
    |> decode_map(Uint32, &to_q_string/1)
  end

  defp to_q_string(value) when value > 0 and value <= 100 do
    (value - 1)
    |> format(2)
    |> ok
  end

  defp to_q_string(value) when value > 100 and value < 1100 do
    (value - 100)
    |> format(3)
    |> ok
  end

  defp to_q_string value do
    error %{out_of_range: value}
  end

  defp format value, digits do
    value
    |> Integer.to_string
    |> String.pad_leading(digits, "0")
  end

  def encode(string) when is_binary(string) do
    string
    |> Integer.parse
    |> pure
    ~> fn integer -> to_q_value integer, byte_size string end
    ~> Uint32.encode
    ~>> fn _ -> encode_error string, :must_be_string_of_2_or_3_digits end
  end

  defp pure({integer, ""}), do: ok integer
  defp pure(_), do: error nil

  defp to_q_value(integer, 2), do: ok integer + 1
  defp to_q_value(integer, 3), do: ok integer + 100
  defp to_q_value(_, _), do: error nil
end
