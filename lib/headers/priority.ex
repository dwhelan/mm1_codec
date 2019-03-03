defmodule MMS.Priority do
  @moduledoc """
  Priority-value = Low | Normal | High

  Low    = <Octet 128>
  Normal = <Octet 129>
  High   = <Octet 130>
  """
  use MMS.Codec2
  import Codec.Map
  alias MMS.ShortInteger

  @values [
    :low,
    :normal,
    :high,
  ]

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode(ShortInteger, @values)
  end

  def encode(value) when is_atom(value) do
    value |> encode(ShortInteger, @values)
  end
end
