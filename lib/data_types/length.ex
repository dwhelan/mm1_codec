defmodule MMS.Length do
  use MMS.Codec

  alias MMS.{ShortLength, Uint32}

  @length_quote 31

  def decode(<<value, _::binary>> = bytes) when is_short_length(value) do
    ShortLength.decode bytes
  end

  def decode <<@length_quote, bytes::binary>> do
    bytes |> Uint32.decode ~>> module_error
  end

  def encode(value) when is_short_length(value) do
    ShortLength.encode value
  end

  def encode(value) when is_uint32(value) do
    value |> Uint32.encode |> prefix_with_length_quote
  end

  defp prefix_with_length_quote {:ok, bytes} do
    ok <<@length_quote>> <> bytes
  end

  defaults()
end
