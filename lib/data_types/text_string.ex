defmodule MMS.TextString do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.Text

  @quote 127

  def decode(<<@quote, byte, _::binary>> = bytes) when byte >= 128 do
    case_ok Text.decode bytes do
      {string, rest} -> ok String.slice(string, 1..-1), rest
    end
  end

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) and byte != @quote do
    bytes |> Text.decode ~>> module_error
  end

  def decode _ do
    error :invalid_text_string
  end

  def encode(<<byte, _::binary>> = string) when byte >= 128 do
    encode <<@quote>> <> string
  end

  def encode(string) when is_binary(string) do
    Text.encode string
  end

  def encode _ do
    error :invalid_text_string
  end
end
