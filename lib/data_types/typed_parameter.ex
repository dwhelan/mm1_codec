defmodule MMS.TypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-parameter = Well-known-parameter-token Typed-value
  """

  use MMS.Codec
  import MMS.As
  alias MMS.{Tuple, WellKnownParameterToken, TypedValue}

  def decode bytes do
    bytes
    |> decode_as(WellKnownParameterToken)
    ~> fn {token, rest} ->
         rest
         |> TypedValue.decode(token)
         ~>> fn {data_type, _, details} -> bytes |> error(nest_error([data_type, details])) end
       end
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
         ~>> fn {data_type, _, details} -> {token, value} |> error(nest_error([data_type, details])) end
       end
  end
end
