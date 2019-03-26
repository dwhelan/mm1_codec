defmodule MMS.CompactValue do
  @moduledoc """
  8.4.2.4 Parameter

  The actual expected type of the value is implied by the well-known parameter.
  In our case the well-known parameter is represented by a `token`.
  In addition to the expected type, there may be no value.

  Compact-value = Integer-value | Date-value | Delta-seconds-value | Q-value | Version-value | Uri-value

  Table 38. Well-Known Parameter Assignments (excerpts)

  |-----------------|--------------------|
  |Token            |Expected Type       |
  |-----------------|--------------------|
  |Q                |Q-value             |
  |Charset          |Well-known-charset  |
  |Level            |Version-value       |
  |Type             |Integer-value       |
  |Name*            |Text-string         |
  |Filename*        |Text-string         |
  |Differences      |Field-name          |
  |Padding          |Short-integer       |
  |Type             |Constrained-encoding|
  |Start*           |Text-string         |
  |Start-info*      |Text-string         |
  |Comment*         |Text-string         |
  |Domain*          |Text-string         |
  |Max-Age          |Delta-seconds-value |
  |Path*            |Text-string         |
  |Secure           |No-value            |
  |SEC              |Short-integer       |
  |MAC              |Text-value          |
  |Creation-date    |Date-value          |
  |Modification-date|Date-value          |
  |Read-date        |Date-value          |
  |Size             |Integer-value       |
  |Name             |Text-value          |
  |Filename         |Text-value          |
  |Start            |Text-value          |
  |Start-info       |Text-value          |
  |Comment          |Text-value          |
  |Domain           |Text-value          |
  |Path             |Text-value          |
  |-----------------|--------------------|

  Note that the second argument, `codec` to `decode` and `encode`, must be a Codec which can decode and encode
  values of the expected type. So, we do not need a `MMS.CompactValue` to implement this.
  """
  use MMS.Codec

  alias MMS.{QValue, WellKnownCharset, VersionValue, IntegerValue, TextString}
  alias MMS.{FieldName, ShortInteger, ConstrainedEncoding, DeltaSecondsValue}
  alias MMS.{NoValue, DateValue, TextValue}

  @codecs %{
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

  def decode bytes, token do
    bytes
    |> do_decode(token, Map.get(@codecs, token))
  end

  defp do_decode bytes, token, nil do
    bytes
    |> decode_error(%{invalid_token: token})
  end

  defp do_decode bytes, token, codec do
    bytes
    |> decode_as(codec, fn value -> {token, value} end)
  end

  def encode {token, value} do
    {token, value}
    |> do_encode(Map.get @codecs, token)
  end

  def do_encode {token, value}, nil do
    {token, value}
    |> encode_error(%{invalid_token: token})
  end

  def do_encode {token, value}, codec do
    value
    |> encode_as(codec)
    ~>> fn {datatype, _, details} -> error datatype, {token, value}, details end
  end
end
