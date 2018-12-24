defmodule MMS.Length do
  alias MMS.{ShortLength, Uint32}

  import MMS.OkError
  import MMS.DataTypes

  @length_quote 31

  def decode(<<value, _::binary>> = bytes) when is_short_length(value) do
    ShortLength.decode bytes
  end

  def decode <<@length_quote, rest::binary>> do
    Uint32.decode rest
  end

  def decode _ do
    error :invalid_length
  end

  def encode(value) when is_short_length(value) do
    ShortLength.encode value
  end

  def encode(value) when is_uint32(value) do
    value |> Uint32.encode |> prefix_with_length_quote
  end

  def encode _ do
    error :must_be_a_uint32
  end

  defp prefix_with_length_quote {:ok, bytes} do
    ok <<@length_quote>> <> bytes
  end
end
