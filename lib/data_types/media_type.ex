defmodule MMS.MediaType do
  @moduledoc """
  8.4.2.24 Content type field

  Media-type = (Well-known-media | Extension-Media) *(Parameter)
  """
  use MMS.Codec
  import MMS.Or

  alias MMS.{WellKnownMedia, ExtensionMedia}

  def decode bytes do
    bytes
    |> decode([WellKnownMedia, ExtensionMedia])
  end

  def encode value do
    value
    |> encode([WellKnownMedia, ExtensionMedia])
  end
end
