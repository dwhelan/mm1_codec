defmodule MMS.TextValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Text-value = No-value | Token-text | Quoted-string
  """
  use MMS.Either

  defcodec either: [MMS.NoValue, MMS.TokenText, MMS.QuotedString]
end
