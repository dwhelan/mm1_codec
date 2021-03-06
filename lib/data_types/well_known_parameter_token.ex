defmodule MMS.WellKnownParameterToken do
  @moduledoc """
  8.4.2.4 Parameter

  Well-known-parameter-token = Integer-value
  """
  import MMS.As

  defcodec as: MMS.IntegerValue
end
