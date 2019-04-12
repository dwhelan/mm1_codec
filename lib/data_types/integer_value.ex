defmodule MMS.IntegerValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Integer-Value = Short-integer | Long-integer
  """
  use MMS.Codec
  import MMS.Or

  @either [MMS.ShortInteger, MMS.LongInteger]

  def decode bytes do
    bytes
    |> decode(@either)
  end

  def encode value do
    value
    |> encode(@either)
  end
end
