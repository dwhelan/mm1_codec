defmodule MMS.TypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-parameter = Well-known-parameter-token Typed-value
  """

  use MMS.Codec
  alias MMS.{WellKnownParameterToken, TypedValue}

  def decode bytes do
    bytes
    |> decode_as(WellKnownParameterToken)
    ~> fn {{token, codec}, rest} ->
         rest
         |> decode_as(codec)
         ~> fn {value, rest} -> decode_ok {token, value}, rest end
       end
  end

  def encode {token, value} do
#    value
#    |> encode_as(WellKnownParameterToken)
#    ~> fn bytes ->
#         rest
#         |> decode_as(codec)
#         ~> fn {value, rest} -> decode_ok {token, value}, rest end
#       end
  end
end
