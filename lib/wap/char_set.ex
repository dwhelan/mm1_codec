defmodule WAP.CharSet do
  @moduledoc """
  Specification: WAP-230-WSP-20010705-a, 7.2.9 Encoded-string-value

  The Char-set values are registered by IANA as MIBEnum values.
  """
  alias WAP.{CharSets, ShortInteger, LongInteger}

  use MM1.BaseCodec

  def decode <<1::1, _::7, _::binary>> = bytes do
    foo ShortInteger, bytes
  end

  def decode bytes do
    foo LongInteger, bytes
  end

  defp foo module, bytes do
    %{value: code, bytes: bytes, rest: rest} = module.decode bytes
    value CharSets.map(code), bytes, rest
  end

  def new name do
    value name, bytes CharSets.code name
  end

  defp bytes(code) when code < 128 do
    <<1::1, code::7>>
  end

  defp bytes code do
    LongInteger.new(code).bytes
  end
end
