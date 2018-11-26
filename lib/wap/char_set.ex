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

  def new name do
    value name, bytes CharSets.unmap(name)
  end

  defp bytes(code) when code < 128 do
    ShortInteger.new(code).bytes
  end

  defp bytes code do
    LongInteger.new(code).bytes
  end
end
