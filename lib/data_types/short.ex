defmodule MMS.Short do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Short-integer = OCTET

    Integers in range 0-127 shall be encoded as a one octet value with the most
    significant bit set to one (1xxx xxxx) and with the value in the remaining
    least significant bits.
  """
  import MMS.OkError
  import MMS.DataTypes

  def decode <<1::1, _::bitstring>> = bytes do
    do_decode bytes
  end

  def decode _ do
    error :invalid_short_integer
  end

  def do_decode <<1::1, value::7, rest::binary>> do
    ok value, rest
  end

  def encode(value) when is_short(value) do
    do_encode value
  end

  def encode _ do
    error :invalid_short_integer
  end

  def do_encode(value) when is_short(value) do
    ok <<value+128>>
  end
end
