defmodule MMS.MediaType do
  @moduledoc """
  8.4.2.24 Content type field

  Media-type = (Well-known-media | Extension-Media) *(Parameter)
  """
  use MMS.Codec
  import MMS.Or

  @either [MMS.WellKnownMedia, MMS.ExtensionMedia]

  def decode bytes do
    bytes
    |> decode(@either)
  end

  def encode value do
    value
    |> encode(@either)
  end
end
