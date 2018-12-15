#
# use EitherCodec,
#   codec: {ShortInteger, is_short_integer_byte, is_short_integer},
#   codec: LongInteger,
#
defmodule MMS.CharSet do
  @moduledoc """
  Specification: WAP-230-WSP-20010705-a, 7.2.9 Encoded-string-value

  The Char-set values are registered by IANA as MIBEnum values.
  """
  alias MMS.{CharSets, ShortInteger, LongInteger}

  import MM1.OkError
  import WAP.Guards

  def decode(<<byte, _::binary>> = bytes) when byte >= 128 do
    bytes |> decode(ShortInteger)
  end

  def decode bytes do
    bytes |> decode(LongInteger)
  end

  defp decode bytes, module do
    bytes |> module.decode |> map
  end

  defp map {:ok, {code, rest}} do
    ok {CharSets.map(code), rest}
  end

  defp map error do
    error
  end

  def encode charset do
    charset |> CharSets.unmap |> _encode
  end

  defp _encode(code) when is_short_integer(code) do
    code |> ShortInteger.encode
  end

  defp _encode code  do
    code |> LongInteger.encode
  end
end
