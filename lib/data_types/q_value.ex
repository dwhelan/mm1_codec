defmodule MMS.QValue do
  use MMS.Codec2, error: :q_value

  alias MMS.Uint32
  import Codec.Map

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> decode_map(Uint32, &to_q_string/1)
  end

  defp to_q_string(value) when value > 0   and value <= 100, do: format (value - 1), 2
  defp to_q_string(value) when value > 100 and value < 1100, do: format (value - 100), 3
  defp to_q_string(value),                                   do: error %{out_of_range: value}

  defp format value, digits do
    value
    |> Integer.to_string
    |> String.pad_leading(digits, "0")
    |> ok
  end

  def encode(string) when is_binary(string) do
    string
    |> map_encode2(&to_q/1, Uint32)
  end

  defp to_q string do
    string
    |> Integer.parse
    |> fn result -> to_q_value(result, byte_size(string)) end.()
  end

  defp to_q_value {integer, ""}, 2 do
    ok integer + 1
  end

  defp to_q_value {integer, ""}, 3 do
    ok integer + 100
  end

  defp to_q_value _, _ do
    error :must_be_string_of_2_or_3_digits
  end
end
