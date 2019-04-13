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

  use MMS.Codec
  alias MMS.Text

  def decode(bytes = <<end_of_string, _::binary>>) when is_end_of_string(end_of_string) do
    bytes
    |> error(:must_have_at_least_one_token_char)
  end

  def decode bytes do
    bytes
    |> decode_as(Text)
    ~> fn {text, rest} ->
          text
          |> first_non_token_char
          ~> fn _ -> ok text, rest end
          ~>> fn reason -> error bytes, reason end
       end
  end

  def encode "" do
    ""
    |> error(:must_have_at_least_one_token_char)
  end

  def encode(string) when is_binary(string) do
    string
    |> first_non_token_char
    ~> fn _  -> string |> encode_as(Text) end
    ~>> fn reason -> error string, reason end
  end

  def encode value do
    value
    |> error :out_of_range
  end

  defp first_non_token_char string do
    non_token_char =
      string
      |> String.to_charlist
      |> Enum.find(fn char -> is_token_char(char) == false end)

    case non_token_char do
      nil -> ok string
      char -> error {:invalid_token_char, char}
    end
  end
end
