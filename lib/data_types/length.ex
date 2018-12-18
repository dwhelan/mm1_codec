defmodule MMS.Length do
  alias MMS.{ShortLength, Uint32}

  import MMS.OkError
  import MMS.DataTypes

  @length_quote 31

  def decode(<<value, _::binary>> = bytes) when is_short_length(value) do
    bytes |> ShortLength.decode
  end

  def decode <<@length_quote, rest::binary>> do
    rest |> Uint32.decode
  end

  def decode _ do
    error :first_byte_must_be_less_than_32
  end

  def encode(value) when is_short_length(value) do
    value |> ShortLength.encode
  end

  def encode(value) when is_uint32(value) do
    ok value |> Uint32.encode |> prefix_with_length_quote
  end

  def encode _ do
    error :must_be_a_uint32
  end

  defp prefix_with_length_quote {:ok, bytes} do
    <<@length_quote>> <> bytes
  end
end
