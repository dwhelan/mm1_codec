defmodule MMS.UntypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Untyped-parameter = Token-text Untyped-value
  """
  import MMS.Tuple

  tuple_codec [MMS.TokenText, MMS.UntypedValue]
end
