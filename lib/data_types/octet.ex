defmodule MMS.Octet do
  @moduledoc """
  Specification WAP-230-WSP-20010705-a

  8.1.1 Primitive Data Types

  octet : 8 bits of opaque data
  """
  use MMS.Codec

  def decode <<byte, rest::binary>> do
    byte |> decode_ok(rest)
  end

  def encode(byte) when is_byte(byte) do
    <<byte>> |> ok
  end

  def encode value do
    value |> encode_error(:out_of_range)
  end
end
