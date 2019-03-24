defmodule MMS.ConstrainedMedia do
  @moduledoc """
  8.4.2.7 Accept field

  Constrained-media = Constrained-encoding
  """

  alias MMS.ConstrainedEncoding

  defdelegate decode(bytes), to: ConstrainedEncoding
  defdelegate encode(value), to: ConstrainedEncoding
end
