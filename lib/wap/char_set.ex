defmodule WAP.CharSet do
  @moduledoc """
  Specification: WAP-230-WSP-20010705-a, 7.2.9 Encoded-string-value

  The Char-set values are registered by IANA as MIBEnum values.
  """

  use MM1.BaseCodec

  def decode <<code, rest::binary>> do
#    bytes ~> WAP.Integer ~> WAP.CharSets
    value :other, <<code>>, rest
  end

  def size(code) when code < 128 do
    1
  end

  def size _ do
    3
  end
end
