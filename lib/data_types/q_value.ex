defmodule MMS.QValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Q-value = 1*2 OCTET
  The encoding is the same as in Uintvar-integer, but with restricted size.
  When quality factor 0 ; and quality factors with one or two decimal digits are encoded,
  they shall be multiplied by 100 ; and incremented by one,
  so that they encode as a one-octet value in range 1-100,

  ie, 0.1 is encoded as 11 (0x0B) and 0.99 encoded as 100 (0x64).
  Three decimal quality factors shall be multiplied with 1000 and incremented by 100,
  and the result shall be encoded ; as a one-octet or two-octet uintvar,

  eg, 0.333 shall be encoded as 0x83 0x31.
  Quality factor 1 is the default value and shall never be sent.
  """
  use MMS.Codec, error: :q_value
  import MMS.As

  alias MMS.UintvarInteger

  def decode bytes do
    bytes
    |> decode_as(UintvarInteger, &to_q_string/1)
  end

  defp to_q_string(uint32) when is_2_digit_q_value(uint32), do: format(uint32 - 1,   2)
  defp to_q_string(uint32) when is_3_digit_q_value(uint32), do: format(uint32 - 100, 3)
  defp to_q_string(uint32),                                 do: error out_of_range: uint32

  defp format uint32, digits do
    uint32
    |> Integer.to_string
    ~> & String.pad_leading &1, digits, "0"
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_as(UintvarInteger, &parse/1)
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
