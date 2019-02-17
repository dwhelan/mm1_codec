defmodule MMS.Text do
  @moduledoc """
  Text = Char *TEXT End-of-string

  This is a convenience codec that handles text.
  Text is any sequence of bytes starting with a "char" and terminated with a "\0".

  End-of-string = <Octet 0>
  """
  use MMS.Codec2

  def decode(<<byte, _::binary>> = bytes) when is_text(byte) do
    bytes |> String.split(<<0>>, parts: 2) |> decode_parts
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :first_byte_must_be_a_char
  end

  defp decode_parts [string | [rest]] do
    ok string, rest
  end

  defp decode_parts [string | []] do
    error string, :missing_end_of_string_0_byte
  end

  def encode(<<byte, _::binary>> = string) when is_char(byte) do
    if string |> String.contains?("\0") do
      error string, :contains_end_of_string_0
    else
      ok string <> <<0>>
    end
  end

  def encode "" do
    ok <<0>>
  end

  def encode(string) when is_binary(string) do
    error string, :first_byte_must_be_a_char
  end
end
