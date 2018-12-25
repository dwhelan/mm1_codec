defmodule MMS.String do
  import MMS.OkError
  import MMS.DataTypes

  def decode(<<byte, _::binary>> = bytes) when is_char (byte) do
    do_decode bytes
  end

  def decode _ do
    error :invalid_string
  end

  def do_decode <<bytes::binary>> do
    bytes |> String.split(<<0>>, parts: 2) |> do_decode
  end

  def do_decode [string | [rest]] do
    ok string, rest
  end

  def do_decode [_string | []] do
    error :missing_terminator
  end

  def encode string do
    ok string <> <<0>>
  end
end
