defmodule MMS.DeltaSecondsValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Delta-seconds-value = Integer-value
  """
  use MMS.Codec
  alias MMS.IntegerValue

  def decode bytes do
    bytes
    |> decode_as(IntegerValue)
  end

  def encode value do
    value
    |> encode_as(IntegerValue)
  end
end
