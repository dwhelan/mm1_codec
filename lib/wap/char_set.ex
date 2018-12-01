#
# use EitherCodec,
#   codec: {ShortInteger, is_short_integer_byte, is_short_integer},
#   codec: LongInteger,
#
defmodule WAP.CharSet do
  @moduledoc """
  Specification: WAP-230-WSP-20010705-a, 7.2.9 Encoded-string-value

  The Char-set values are registered by IANA as MIBEnum values.
  """
  alias WAP.{CharSets, ShortInteger, LongInteger}

  use MM1.Codecs.Default

  def decode(<<byte, _::binary>> = bytes) when is_short_integer_byte(byte) do
    _decode bytes, ShortInteger
  end

  def decode bytes do
    _decode bytes, LongInteger
  end

  defp _decode bytes, module do
    bytes |> module.decode |> CharSets.map |> set_module
  end

  def new(name) when is_atom(name) do
    _new CharSets.unmap name
  end

  def new(code) when is_integer(code) and code >= 0 do
    _new code
  end

  def new code do
    new_error :must_be_an_integer_greater_than_or_equal_to_0, code
  end

  defp _new(name) when is_atom(name) do
    new_error :unknown_char_set, name
  end

  defp _new code do
    new_ok CharSets.map(code), bytes(code)
  end

  defp bytes(code) when is_short_integer(code) do
    ShortInteger.new(code).bytes
  end

  defp bytes code do
    LongInteger.new(code).bytes
  end
end
