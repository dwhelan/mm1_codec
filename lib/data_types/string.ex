defmodule MMS.String do
  import MMS.OkError
  import MMS.DataTypes

  def decode(<<byte, _::binary>> = bytes) when is_char (byte) do
    do_decode bytes
  end

  def decode _ do
    error :invalid_string
  end

  def do_decode(<<byte, _::binary>> = bytes) when is_char (byte) do
    bytes |> String.split(<<0>>, parts: 2) |> decode_parts
  end

  defp decode_parts [string | [rest]] do
    ok string, rest
  end

  defp decode_parts [_string | []] do
    error :missing_terminator
  end

  def encode(string) when is_binary(string) do
    do_encode string
  end

  def encode _ do
    error :invalid_string
  end

  def do_encode(string) when is_binary(string) do
    ok string <> <<0>>
  end
end
