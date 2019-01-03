defmodule MMS.QuotedString do
  use MMS.Codec

  alias MMS.Text

  @quote_char 34

  def decode <<@quote_char, bytes::binary>> do
    bytes |> Text.decode ~> map_value(tokenize)
  end

  def tokenize value do
    {value}
  end

  def encode({string}) when is_binary(string) do
    string |> Text.encode ~> quote_string
  end

  defp quote_string bytes do
    <<@quote_char>> <> bytes
  end

  defaults()
end
