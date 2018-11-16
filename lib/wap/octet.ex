defmodule WAP.Octet do
  @moduledoc """
  """

  use MM1.BaseCodec

  def decode <<octet, _::binary>> = bytes do
    return octet, 1, bytes
  end

  def encode value do
    <<value>>
  end
end

