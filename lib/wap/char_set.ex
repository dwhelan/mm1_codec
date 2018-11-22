defmodule WAP.CharSet do
  @moduledoc """
  Specification: WAP-230-WSP-20010705-a, 7.2.9 Encoded-string-value

  The Char-set values are registered by IANA as MIBEnum values.
  """
  alias WAP.CharSets

  use MM1.BaseCodec

  def decode <<1::1, code::7, rest::binary>> do
    value CharSets.name(code), <<1::1, code::7>>, rest
  end

  def decode bytes do
    code = WAP.LongInteger.decode bytes
    return %Result{code | value: CharSets.name(code.value)}
  end

  def size(code) when code < 128 do
    1
  end

  def size _ do
    3
  end
end
