defmodule MMS.WellKnownParameterToken do
  @moduledoc """
  8.4.2.4 Parameter

  Well-known-parameter-token = Integer-value

  The code values used for parameters are specified in the Assigned Numbers appendix.

  Table 38. Well-Known Parameter Assignments

  The table is shown without the `Encoding Version`
  |-----------------|----------------|--------------------|
  |Token            |Assigned Number |BNF Rule for Value  |
  |-----------------|----------------|--------------------|
  |Q                |0x00            |Q-value             |
  |Charset          |0x01            |Well-known-charset  |
  |Level            |0x02            |Version-value       |
  |Type             |0x03            |Integer-value       |
  |Name*            |0x05            |Text-string         |
  |Filename*        |0x06            |Text-string         |
  |Differences      |0x07            |Field-name          |
  |Padding          |0x08            |Short-integer       |
  |Type             |0x09            |Constrained-encoding|
  |Start*           |0x0A            |Text-string         |
  |Start-info*      |0x0B            |Text-string         |
  |Comment*         |0x0C            |Text-string         |
  |Domain*          |0x0D            |Text-string         |
  |Max-Age          |0x0E            |Delta-seconds-value |
  |Path*            |0x0F            |Text-string         |
  |Secure           |0x10            |No-value            |
  |SEC              |0x11            |Short-integer       |
  |MAC              |0x12            |Text-value          |
  |Creation-date    |0x13            |Date-value          |
  |Modification-date|0x14            |Date-value          |
  |Read-date        |0x15            |Date-value          |
  |Size             |0x16            |Integer-value       |
  |Name             |0x17            |Text-value          |
  |Filename         |0x18            |Text-value          |
  |Start            |0x19            |Text-value          |
  |Start-info       |0x1A            |Text-value          |
  |Comment          |0x1B            |Text-value          |
  |Domain           |0x1C            |Text-value          |
  |Path             |0x1D            |Text-value          |
  |-----------------|----------------|--------------------|

  Note: * These numbers have been deprecated and should not be used.

  This codec represents a well known parameter token as a `Tuple`
  of `{token, codec}`.
  """

  use MMS.Codec

  alias MMS.{QValue, WellKnownCharset, VersionValue, IntegerValue, TextString}
  alias MMS.{FieldName, ShortInteger, ConstrainedEncoding, DeltaSecondsValue}
  alias MMS.{NoValue, DateValue, TextValue}

  @map %{
    # Assigned Number => {Token                       Codec}
    0x00              => {:q,                         QValue},
    0x01              => {:charset,                   WellKnownCharset},
    0x02              => {:level,                     VersionValue},
    0x03              => {:type,                      IntegerValue},
    0x05              => {:"name (deprecated)",       TextString},
    0x06              => {:"file_name (deprecated)",  TextString},
    0x07              => {:differences,               FieldName},
    0x08              => {:padding,                   ShortInteger},
    0x09              => {:type_multipart,            ConstrainedEncoding},
    0x0A              => {:"start (deprecated)",      TextString},
    0x0B              => {:"start_info (deprecated)", TextString},
    0x0C              => {:"comment (deprecated)",    TextString},
    0x0D              => {:"domain (deprecated)",     TextString},
    0x0E              => {:max_age,                   DeltaSecondsValue},
    0x0F              => {:"path (deprecated)",       TextString},
    0x10              => {:secure,                    NoValue},
    0x11              => {:sec,                       ShortInteger},
    0x12              => {:mac,                       TextValue},
    0x13              => {:creation_date,             DateValue},
    0x14              => {:modification_date,         DateValue},
    0x15              => {:read_date,                 DateValue},
    0x16              => {:size,                      IntegerValue},
    0x17              => {:name,                      TextValue},
    0x18              => {:file_name,                 TextValue},
    0x19              => {:start,                     TextValue},
    0x1A              => {:start_info,                TextValue},
    0x1B              => {:comment,                   TextValue},
    0x1C              => {:domain,                    TextValue},
    0x1D              => {:path,                      TextValue},
  }

  def decode bytes do
    bytes
    |> decode_as(IntegerValue, @map)
  end

  def encode {token, codec} do
    {token, codec}
    |> encode_as(IntegerValue, @map)
  end
end
