defmodule MMS.Octet do
  @moduledoc """
  8.1.1 Primitive Data Types

  octet : 8 bits of opaque data
  """
  use MMS.Codec

  def decode <<octet, rest::binary>> do
    ok octet, rest
  end

  def encode(octet) when octet in 0..255 do
    ok <<octet>>
  end

  def encode value do
    error value, :out_of_range
  end
end
