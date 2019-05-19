defmodule MMS.ConstrainedEncoding do
  @moduledoc """
  8.4.2.1 Basic rules

  Constrained-encoding = Extension-Media | Short-integer

  This encoding is used for token values, which have no well-known binary encoding, or when
  the assigned number of the well-known encoding is small enough to fit into Short-integer.
  """
  import MMS.Either

  defcodec as: [MMS.ExtensionMedia, MMS.ShortInteger]
end
