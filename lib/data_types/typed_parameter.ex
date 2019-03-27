defmodule MMS.TypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-parameter = Well-known-parameter-token Typed-value
  """

  use MMS.Codec
  alias MMS.{Tuple, WellKnownParameterToken, TypedValue}

  def decode bytes do
    bytes
    |> Tuple.decode([WellKnownParameterToken, TypedValue])
  end

  def encode {token, value} do
    {token, value}
    |> Tuple.encode([WellKnownParameterToken, TypedValue])
  end
end
