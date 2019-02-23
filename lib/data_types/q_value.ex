defmodule MMS.QValue do
  use MMS.Codec2, error: :q_value

  alias MMS.Uint32
  import Codec.Map

  def decode bytes do
    bytes
    |> decode_map(Uint32, &to_q/1)
  end

  def decode_old bytes do
    bytes
    |> Uint32.decode
    ~> fn result -> to_q_string(result) end
    ~>> fn error -> decode_error bytes, error end
  end

  defp to_q_string({q_value, rest}) when q_value > 0 and q_value <= 100 do
    (q_value - 1)
    |> format(2)
    |> ok(rest)
  end

  defp to_q_string({q_value, rest}) when q_value > 100 and q_value < 1100 do
    (q_value - 100)
    |> format(3)
    |> ok(rest)
  end

  defp to_q_string {q_value, _rest} do
    error %{out_of_range: q_value}
  end

  defp to_q(q_value) when q_value > 0 and q_value <= 100 do
    (q_value - 1)
    |> format(2)
    |> ok
  end

  defp to_q(q_value) when q_value > 100 and q_value < 1100 do
    (q_value - 100)
    |> format(3)
    |> ok
  end

  defp to_q q_value do
    error %{out_of_range: q_value}
  end

  defp format q_value, digits do
    q_value
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
