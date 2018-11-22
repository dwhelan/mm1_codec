defmodule WAP.EncodedString do
  use MM1.BaseCodec

  alias WAP.{ValueLength, CharSet, TextString}

  def decode(<<char, _::binary>> = data) when char >= 32 do
    data ~> TextString
  end

  def decode data do
    data ~> ValueLength ~> CharSet ~> TextString
  end
end
