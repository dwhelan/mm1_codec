defmodule MMS.DeltaSecondsValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Delta-seconds-value = Integer-value
  """
  import MMS.As

  defcodec as: MMS.IntegerValue
end
