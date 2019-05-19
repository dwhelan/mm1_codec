defmodule MMS.TypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-parameter = Well-known-parameter-token Typed-value
  """
  use MMS.Codec
  import MMS.As

  alias MMS.{WellKnownParameterToken, TypedValue}

  def decode bytes do
    bytes
    |> decode_as(WellKnownParameterToken)
    ~> fn {token, rest} ->
         rest
         |> TypedValue.decode(token)
       end
    ~>> & error(bytes, &1)
  end

  def encode {token, value} do
    token
    |> encode_as(WellKnownParameterToken)
    ~> fn token_bytes ->
         {token, value}
         |> TypedValue.encode
         ~> fn value_bytes ->
              ok token_bytes <> value_bytes
            end
       end
    ~>> & error({token, value}, &1)
  end

  def encode value do
    super value
  end
end
