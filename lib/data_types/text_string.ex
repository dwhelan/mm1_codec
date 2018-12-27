defmodule MMS.TextString do
  import MMS.OkError
  import MMS.DataTypes

  @quote 127

  def decode(<<@quote, byte, _::binary>> = bytes) when byte >= 128 do
    case_ok MMS.String.decode bytes do
      {string, rest} -> ok String.slice(string, 1..-1), rest
    end
  end

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) do
    MMS.String.decode bytes
  end

  def decode _ do
    error :invalid_text_string
  end

  def encode(<<byte, _::binary>> = string) when byte >= 128 do
    ok <<@quote>> <> string <> <<0>>
  end

  def encode(string) when is_binary(string) do
    ok string <> <<0>>
  end

  def encode _ do
    error :invalid_text_string
  end
end
