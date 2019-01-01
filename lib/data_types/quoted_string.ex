defmodule MMS.QuotedString do
  import MMS.OkError

  alias MMS.Text

  @quote_char 34

  def decode <<@quote_char, bytes::binary>> do
    case_ok Text.decode bytes do
      {value, rest} -> ok {value}, rest
    end
  end

  def decode _ do
    error :invalid_quoted_string
  end

  def encode({string}) when is_binary(string) do
    string |> Text.encode ~> quote_string
  end

  def encode _ do
    error :invalid_quoted_string
  end

  defp quote_string bytes do
    <<@quote_char>> <> bytes
  end
end
