defmodule MMS.QValue do
  use MMS.Codec, error: :q_value

  alias MMS.Uint32
  import Codec.Map

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode(Uint32, &to_q_string/1)
  end

  defp to_q_string(uint32) when is_2_digit_q_value(uint32), do: format(uint32 - 1,   2)
  defp to_q_string(uint32) when is_3_digit_q_value(uint32), do: format(uint32 - 100, 3)
  defp to_q_string(uint32),                                 do: error %{out_of_range: uint32}

  defp format uint32, digits do
    uint32
    |> Integer.to_string
    ~> & String.pad_leading &1, digits, "0"
  end

  def encode(string) when is_binary(string) do
    string |> encode(Uint32, &parse/1)
  end

  defp parse string do
    string
    |> Integer.parse
    ~> & to_q_value &1, byte_size(string)
  end

  defp to_q_value({integer, ""}, 2), do: integer + 1
  defp to_q_value({integer, ""}, 3), do: integer + 100
  defp to_q_value(_, _),             do: error :must_be_string_of_2_or_3_digits
end
