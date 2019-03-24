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
  alias MMS.Text

  def decode(bytes = <<@end_of_string, _::binary>>) do
    bytes
    |> decode_error(:must_have_at_least_one_token_char)
  end

  def decode bytes do
    bytes
    |> decode_as(Text)
    ~> fn {text, rest} ->
          non_token =
            text
            |> String.to_charlist
            |> Enum.find(fn octet -> is_token_char(octet) == false end)

          case non_token do
            nil -> decode_ok text, rest
            octet -> decode_error bytes, {:invalid_token_char, octet}
          end
       end
  end

  def encode(string = <<token, _::binary>>) when is_token_char(token) do
    string
    |> encode_as(Text)
  end

  def encode "" do
    ""
    |> encode_error(:must_have_at_least_one_token_char)
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_error(:first_char_is_not_a_token_char)
  end
end
