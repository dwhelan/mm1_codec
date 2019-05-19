defmodule MMS.TextValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Text-value = No-value | Token-text | Quoted-string
  """
  import MMS.Either

  defcodec as: [MMS.NoValue, MMS.TokenText, MMS.QuotedString]
end
