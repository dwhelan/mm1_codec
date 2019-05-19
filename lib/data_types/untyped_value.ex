defmodule MMS.UntypedValue do
  @moduledoc """
  8.4.2.4 Parameter

  Untyped-value = Integer-value | Text-value
  """
  import MMS.Either

  defcodec as: [MMS.IntegerValue, MMS.TextValue]
end
