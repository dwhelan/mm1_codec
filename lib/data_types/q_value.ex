defmodule MMS.QValue do
  use MMS.Codec2, error: :q_value

  alias MMS.Uint32
  import Codec.Map

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> decode_map(Uint32, &to_q_string/1)
  end

  defp to_q_string(uint32) when is_2_digit_q_value(uint32), do: format((uint32 - 1), 2)
  defp to_q_string(uint32) when is_3_digit_q_value(uint32), do: format((uint32 - 100), 3)
  defp to_q_string(uint32),                                 do: error %{out_of_range: uint32}

  defp format value, digits do
    value
    |> Integer.to_string
    |> String.pad_leading(digits, "0")
    |> ok
  end

  def encode(string) when is_binary(string) do
    string
    |> map_encode(&parse/1, Uint32)
#    |> map_encode2(fn x -> parse x end, Uint32)
  end

  defp parse string do
    string
    |> Integer.parse
    |> fn result -> to_q_value(result, byte_size(string)) end.()
  end

  defp to_q_value({integer, ""}, 2), do: ok(integer + 1)
  defp to_q_value({integer, ""}, 3), do: ok(integer + 100)
  defp to_q_value(_, _),             do: error :must_be_string_of_2_or_3_digits
end
