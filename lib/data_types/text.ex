defmodule MMS.Text do
  use MMS.Codec

  def decode(<<byte, _::binary>> = bytes) when is_char (byte) do
    bytes |> String.split(<<0>>, parts: 2) |> decode_parts
  end

  defp decode_parts [string | [rest]] do
    ok string, rest
  end

  defp decode_parts [_string | []] do
    error()
  end

  def encode "" do
    ok <<0>>
  end

  def encode(<<byte, _::binary>> = string) when is_char(byte) do
    if String.contains?(string, "\0") do
      error()
    else
      ok string <> <<0>>
    end
  end

  defaults()
end
