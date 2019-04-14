defmodule MMS.TextValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Text-value = No-value | Token-text | Quoted-string
  """
  use MMS.Codec
  import MMS.Or

  @either [MMS.NoValue, MMS.TokenText, MMS.QuotedString]

  def decode bytes do
    bytes
    |> decode(@either)
  end

  def encode value do
    value
    |> encode(@either)
  end
qend
