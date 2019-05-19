defmodule MMS.Parameter do
  @moduledoc """
  8.4.2.4 Parameter

  Parameter = Typed-parameter | Untyped-parameter
  """
  import MMS.Tuple

  defcodec as: [MMS.TypedParameter, MMS.UntypedParameter]
end
