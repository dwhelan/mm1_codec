defmodule MMS.Parameter do
  @moduledoc """
  8.4.2.4 Parameter

  Parameter = Typed-parameter | Untyped-parameter
  """
  use MMS.Tuple

  # This does not match BNF above
  defcodec as: {MMS.TokenText, MMS.UntypedValue}
end
