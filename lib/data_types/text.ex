defmodule MMS.Text do
  @moduledoc """
  Text = Char *TEXT End-of-string

  This is a convenience codec that handles text.
  Text is any sequence of bytes starting with a "char" and terminated with a "\0".

  End-of-string = <Octet 0>
  """

  @end_of_string <<0>>

  use MMS.Codec2

  def decode(bytes = <<byte, _::binary>>) when is_text(byte) do
    bytes
    |> String.split(@end_of_string, parts: 2)
    |> do_decode
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_error(:first_byte_must_be_a_zero_or_a_char)
  end

  defp do_decode [string | [rest]] do
    ok string, rest
  end

  defp do_decode [string | []] do
    string |> decode_error(:missing_end_of_string)
  end

  def encode(string = <<char, _::binary>>) when is_char(char) do
    string |> do_encode(String.contains?(string, @end_of_string))
  end

  def encode string = "" do
    string |> do_encode(false)
  end

  def encode(string) when is_binary(string) do
    string |> encode_error(:first_byte_must_be_a_zero_or_a_char)
  end

  defp do_encode string, _end_of_string = true do
    string |> encode_error(:contains_end_of_string)
  end

  defp do_encode string, _end_of_string = false do
    ok string <> @end_of_string
  end
end
