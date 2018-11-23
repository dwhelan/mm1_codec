defmodule WAP.Byte do
  use MM1.BaseCodec

  def decode <<value, rest::binary>> do
    value value, <<value>>, rest
  end

  def new value do
    <<byte>> = <<value>>
    value byte, <<byte>>
  end
end
