defmodule MMS.NoValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  The following rules are used in encoding parameter values.
  No-value = <Octet 0>
  """
  import MMS.As

  defcodec as: MMS.Octet, map: %{
    0 => :no_value
  }
end
