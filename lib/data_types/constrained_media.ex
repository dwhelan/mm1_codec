defmodule MMS.ConstrainedMedia do
  @moduledoc """
  8.4.2.7 Accept field

  Constrained-media = Constrained-encoding

  """
  import MMS.Codec

  defcodec as: MMS.ConstrainedEncoding
end
