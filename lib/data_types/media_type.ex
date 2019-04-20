defmodule MMS.MediaType do
  @moduledoc """
  8.4.2.24 Content type field

  Media-type = (Well-known-media | Extension-Media) *(Parameter)
  """
  use MMS.Either

  defcodec either: [MMS.WellKnownMedia, MMS.ExtensionMedia]
end
