defmodule MMS.DeltaSecondsValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Delta-seconds-value = Integer-value
  """
  alias MMS.IntegerValue

  defdelegate decode(bytes), to: IntegerValue
  defdelegate encode(value), to: IntegerValue
end
