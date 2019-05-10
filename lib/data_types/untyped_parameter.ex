defmodule MMS.UntypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Untyped-parameter = Token-text Untyped-value
  """
  use MMS.Tuple

  defcodec as: {MMS.TokenText, MMS.UntypedValue}
end
