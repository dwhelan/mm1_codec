defmodule MMS.QuotedString do
  import MMS.OkError
  import MMS.DataTypes

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
    case_ok Text.encode string do
      bytes -> ok <<@quote_char>> <> bytes
    end
  end

  def encode _ do
    error :invalid_quoted_string
  end
end
