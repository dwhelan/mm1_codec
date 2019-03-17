defmodule MMS.TokenText do
  @moduledoc """
  8.4.2.1 Basic rules

  Token-text = Token End-of-string
  End-of-string = <Octet 0>

  From RFC 2616 (HTTP/1.1 June 1999):

  token          = 1*<any CHAR except CTLs or separators>
  CHAR           = <any US-ASCII character (octets 0 - 127)>
  CTL            = <any US-ASCII control character (octets 0 - 31) and DEL (127)>
  separators     = "(" | ")" | "<" | ">" | "@"
                 | "," | ";" | ":" | "\\" | <">
                 | "/" | "[" | "]" | "?" | "="
                 | "{" | "}" | SP | HT
  SP             = <US-ASCII SP, space (32)>
  HT             = <US-ASCII HT, horizontal-tab (9)>
  """

  @end_of_string <<0>>

  use MMS.Codec

  def decode(bytes = <<@end_of_string, _::binary>>) do
    bytes
    |> decode_error(:must_have_at_least_one_token_char)
  end

  def decode(bytes = <<token, _::binary>>) when is_token_char(token) do
    bytes
    |> decode_as(MMS.Text)
  end

  def decode bytes do
    bytes
    |> decode_error(:first_byte_must_be_a_token_char)
  end

  def encode(string = <<char, _::binary>>) when is_char(char) do
    string |> do_encode(String.contains?(string, @end_of_string))
  end

  def encode "" do
    ""
    |> encode_error(:must_have_at_least_one_character)
  end

  def encode(string) when is_binary(string) do
    string |> encode_error(:first_byte_must_be_a_zero_or_a_char)
  end

  defp do_encode string, _end_of_string = true do
    string |> encode_error(:contains_end_of_string)
  end

  defp do_encode string, _end_of_string = false do
    string <> @end_of_string |> ok
  end
end
