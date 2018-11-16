defmodule WAP.Octet do
  @moduledoc """
  """

  use MM1.BaseCodec

  def decode <<octet, _::binary>> = byte do
    return octet, 1, byte
  end

  def encode value do
    <<value>>
  end
end

