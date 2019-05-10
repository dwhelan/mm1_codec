defmodule MMS.Parameter do
  @moduledoc """
  8.4.2.4 Parameter

  Parameter = Typed-parameter | Untyped-parameter
  """
  import MMS.Tuple

  # This does not match BNF above
  tuple_codec [MMS.TokenText, MMS.UntypedValue]
end
