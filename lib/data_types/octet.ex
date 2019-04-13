defmodule MMS.Octet do
  @moduledoc """
  8.1.1 Primitive Data Types

  octet : 8 bits of opaque data
  """
  use MMS.Codec

  def decode <<octet, rest::binary>> do
    octet
    |> ok(rest)
  end

  def encode(octet) when is_octet(octet) do
    <<octet>>
    |> ok
  end

  def encode value do
    value
    |> encode_error(:out_of_range)
  end
end
