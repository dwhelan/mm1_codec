defmodule MMS.MediaType do
  @moduledoc """
  8.4.2.24 Content type field

  Media-type = (Well-known-media | Extension-Media) *(Parameter)
  """

  import MMS.Either

  defcodec as: [MMS.WellKnownMedia, MMS.ExtensionMedia]

  defmodule WellKnownMediaOrExtensionMedia do
    defcodec as: [MMS.WellKnownMedia, MMS.ExtensionMedia]
  end
end
