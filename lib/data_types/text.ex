defmodule MMS.Text do
  @moduledoc """

  """
  use MMS.Codec2

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) do
    bytes |> String.split(<<0>>, parts: 2) |> decode_parts
  end

  def decode(bytes) when is_binary(bytes) do
    error :invalid_text, bytes, :first_byte_must_be_a_char
  end

  defp decode_parts [string | [rest]] do
    ok string, rest
  end

  defp decode_parts [string | []] do
    error :invalid_text, string, :missing_end_of_string_byte_of_0
  end

  def encode(<<byte, _::binary>> = string) when is_char(byte) do
    if string |> String.contains?("\0") do
      error :invalid_text, string, :contain_end_of_string_byte_of_0
    else
      ok string <> <<0>>
    end
  end

  def encode "" do
    ok <<0>>
  end

  def encode(string) when is_binary(string) do
    error :invalid_text, string, :first_byte_must_be_a_char
  end
end
