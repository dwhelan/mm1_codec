defmodule MMS.WellKnownFieldName do
  @moduledoc """
  8.4.2.6 Header

  Well-known-field-name = Short-integer
  """
  alias MMS.ShortInteger

  defdelegate decode(bytes), to: ShortInteger
  defdelegate encode(value), to: ShortInteger
end
