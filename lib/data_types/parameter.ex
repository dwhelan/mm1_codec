defmodule MMS.Parameter do
  @moduledoc """
  8.4.2.4 Parameter

  Parameter = Typed-parameter | Untyped-parameter
  """
  import MMS.Tuple

  tuple_codec [MMS.TypedParameter, MMS.UntypedParameter]
end
