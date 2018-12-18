#
# use EitherCodec,
#   codec: {Short, is_short_byte, is_short},
#   codec: Long,
#
defmodule MMS.Charset do
  @moduledoc """
  Specification: WAP-230-WSP-20010705-a, 7.2.9 Encoded-string-value

  The Char-set values are registered by IANA as MIBEnum values.
  """
  alias MMS.{Charsets, Short, Long}

  import MMS.OkError
  import MMS.DataTypes

  def decode(<<byte, _::binary>> = bytes) when byte >= 128 do
    bytes |> decode(Short)
  end

  def decode bytes do
    bytes |> decode(Long)
  end

  defp decode bytes, module do
    bytes |> module.decode |> map
  end

  defp map {:ok, {code, rest}} do
    ok Charsets.map(code), rest
  end

  defp map error do
    error
  end

  def encode charset do
    charset |> Charsets.unmap |> _encode
  end

  defp _encode(code) when is_short(code) do
    code |> Short.encode
  end

  defp _encode code  do
    code |> Long.encode
  end
end
