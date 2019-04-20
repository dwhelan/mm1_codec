defmodule MMS.UntypedValue do
  @moduledoc """
  8.4.2.4 Parameter

  Untyped-value = Integer-value | Text-value
  """
  use MMS.Either

  defcodec either: [MMS.IntegerValue, MMS.TextValue]
end
