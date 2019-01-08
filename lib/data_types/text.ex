defmodule MMS.Text do
  use MMS.Codec

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) do
    bytes |> String.split(<<0>>, parts: 2) |> decode_parts
  end

  defp decode_parts [string | [rest]] do
    ok string, rest
  end

  defp decode_parts [_string | []] do
    module_error()
  end

  def encode(<<byte, _::binary>> = string) when is_char(byte) do
    if string |> String.contains?("\0") do
      module_error()
    else
      ok string <> <<0>>
    end
  end

  def encode "" do
    ok <<0>>
  end

  defaults()
end
