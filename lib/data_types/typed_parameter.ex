defmodule MMS.TypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-parameter = Well-known-parameter-token Typed-value
  """

  use MMS.Codec
  alias MMS.{WellKnownParameterToken, TypedValue}

  @map %{
    :q                         => QValue,
    :charset                   => WellKnownCharset,
    :level                     => VersionValue,
    :type                      => IntegerValue,
    :"name (deprecated)"       => TextString,
    :"file_name (deprecated)"  => TextString,
    :differences               => FieldName,
    :padding                   => ShortInteger,
    :type_multipart            => ConstrainedEncoding,
    :"start (deprecated)"      => TextString,
    :"start_info (deprecated)" => TextString,
    :"comment (deprecated)"    => TextString,
    :"domain (deprecated)"     => TextString,
    :max_age                   => DeltaSecondsValue,
    :"path (deprecated)"       => TextString,
    :secure                    => NoValue,
    :sec                       => ShortInteger,
    :mac                       => TextValue,
    :creation_date             => DateValue,
    :modification_date         => DateValue,
    :read_date                 => DateValue,
    :size                      => IntegerValue,
    :name                      => TextValue,
    :file_name                 => TextValue,
    :start                     => TextValue,
    :start_info                => TextValue,
    :comment                   => TextValue,
    :domain                    => TextValue,
    :path                      => TextValue,
  }

  def decode bytes do
    bytes
    |> decode_as(WellKnownParameterToken)
    ~> fn {token, rest} ->
         Map.get @map, token
         ~> fn codec ->
              rest
              |> decode_as(codec)
              ~> fn {value, rest} -> decode_ok {token, value}, rest end
            end
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
