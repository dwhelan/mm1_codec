defmodule MMS.FieldName do
  @moduledoc """
  8.4.2.6 Header

  Field-name = Token-text | Well-known-field-name

  This encoding is used for token values, which have no well-known binary encoding, or when
  the assigned number of the well-known encoding is small enough to fit into Short-integer.
  """
  import MMS.Either

  defcodec as: [MMS.TokenText, MMS.WellKnownFieldName]
end
