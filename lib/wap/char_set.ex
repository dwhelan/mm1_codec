defmodule WAP.CharSet do
  @moduledoc """
  Specification: WAP-230-WSP-20010705-a, 7.2.9 Encoded-string-value

  The Char-set values are registered by IANA as MIBEnum values.
  """
  alias WAP.{CharSets, ShortInteger, LongInteger}

  use MM1.BaseCodec

  def decode(<<value, _::binary>> = bytes) when value >= 128 do
    bytes |> ShortInteger.decode |> map
  end

  def decode bytes do
    bytes |> LongInteger.decode |> map
  end

  defp map result do
    result |> CharSets.map |> return
  end

  def new(name) when is_atom(name) do
    _new CharSets.unmap name
  end

  def new(code) when is_integer(code) and code >= 0 do
    _new code
  end

  def new code do
    error :must_be_an_integer_greater_than_or_equal_to_0, code
  end

  defp _new(name) when is_atom(name) do
    error :unknown_char_set, name
  end

  defp _new code do
    value CharSets.map(code), bytes(code)
  end

  defp bytes(code) when code < 128 do
    ShortInteger.new(code).bytes
  end

  defp bytes code do
    LongInteger.new(code).bytes
  end
end
