defmodule MMS.QuotedString do
  use MMS.Codec

  alias MMS.Text

  def decode <<?", _::binary>> = bytes do
    bytes |> Text.decode ~> map_value(quote_string)
  end

  defp quote_string string do
    string <> "\""
  end

  def encode(string) when is_binary(string) do
    string |> unquote_string |> Text.encode
  end

  defp unquote_string string do
    string |> String.slice(0..-2)
  end

  defaults()
end
