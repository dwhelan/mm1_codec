defmodule MMS.ConstrainedEncoding do
  @moduledoc """
  8.4.2.1 Basic rules

  Constrained-encoding = Extension-Media | Short-integer

  This encoding is used for token values, which have no well-known binary encoding, or when
  the assigned number of the well-known encoding is small enough to fit into Short-integer.
  """
  use MMS.Codec
  import MMS.Or

  alias MMS.{ExtensionMedia, ShortInteger}

  def decode bytes do
    bytes
    |> decode([ExtensionMedia, ShortInteger])
  end

  def encode value do
    value
    |> encode([ExtensionMedia, ShortInteger])
  end
#
#  def encode(string) when is_binary(string) do
#    string
#    |> encode_as(ExtensionMedia)
#  end
#
#  def encode(short_integer) when is_short_integer(short_integer) do
#    short_integer
#    |> encode_as(ShortInteger)
#  end
end
