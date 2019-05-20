defmodule MMS.TypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-parameter = Well-known-parameter-token Typed-value

  Table 38. Well-Known Parameter Assignments (excerpts)

  |----------------|-----------------|--------------------|
  |Assigned Number |Token            |Expected Type       |
  |----------------|-----------------|--------------------|
  |0x00            |Q                |Q-value             |
  |0x01            |Charset          |Well-known-charset  |
  |0x02            |Level            |Version-value       |
  |0x03            |Type             |Integer-value       |
  |0x05            |Name*            |Text-string         |
  |0x06            |Filename*        |Text-string         |
  |0x07            |Differences      |Field-name          |
  |0x08            |Padding          |Short-integer       |
  |0x09            |Type             |Constrained-encoding|
  |0x0A            |Start*           |Text-string         |
  |0x0B            |Start-info*      |Text-string         |
  |0x0C            |Comment*         |Text-string         |
  |0x0D            |Domain*          |Text-string         |
  |0x0E            |Max-Age          |Delta-seconds-value |
  |0x0F            |Path*            |Text-string         |
  |0x10            |Secure           |No-value            |
  |0x11            |SEC              |Short-integer       |
  |0x12            |MAC              |Text-value          |
  |0x13            |Creation-date    |Date-value          |
  |0x14            |Modification-date|Date-value          |
  |0x15            |Read-date        |Date-value          |
  |0x16            |Size             |Integer-value       |
  |0x17            |Name             |Text-value          |
  |0x18            |Filename         |Text-value          |
  |0x19            |Start            |Text-value          |
  |0x1A            |Start-info       |Text-value          |
  |0x1B            |Comment          |Text-value          |
  |0x1C            |Domain           |Text-value          |
  |0x1D            |Path             |Text-value          |
  |----------------|-----------------|--------------------|

  Note: * These numbers have been deprecated and should not be used.

  `Typed-value is handled by the codec in the `NameValue` map.
  """
  import MMS.NameValue

  defcodec as: MMS.WellKnownParameterToken, map: %{
    0x00 => {:q,                         MMS.QValue},
    0x01 => {:charset,                   MMS.WellKnownCharset},
    0x02 => {:level,                     MMS.VersionValue},
    0x03 => {:type,                      MMS.IntegerValue},
    0x05 => {:"name (deprecated)",       MMS.TextString},
    0x06 => {:"file_name (deprecated)",  MMS.TextString},
    0x07 => {:differences,               MMS.FieldName},
    0x08 => {:padding,                   MMS.ShortInteger},
    0x09 => {:type_multipart,            MMS.ConstrainedEncoding},
    0x0A => {:"start (deprecated)",      MMS.TextString},
    0x0B => {:"start_info (deprecated)", MMS.TextString},
    0x0C => {:"comment (deprecated)",    MMS.TextString},
    0x0D => {:"domain (deprecated)",     MMS.TextString},
    0x0E => {:max_age,                   MMS.DeltaSecondsValue},
    0x0F => {:"path (deprecated)",       MMS.TextString},
    0x10 => {:secure,                    MMS.NoValue},
    0x11 => {:sec,                       MMS.ShortInteger},
    0x12 => {:mac,                       MMS.TextValue},
    0x13 => {:creation_date,             MMS.DateValue},
    0x14 => {:modification_date,         MMS.DateValue},
    0x15 => {:read_date,                 MMS.DateValue},
    0x16 => {:size,                      MMS.IntegerValue},
    0x17 => {:name,                      MMS.TextValue},
    0x18 => {:file_name,                 MMS.TextValue},
    0x19 => {:start,                     MMS.TextValue},
    0x1A => {:start_info,                MMS.TextValue},
    0x1B => {:comment,                   MMS.TextValue},
    0x1C => {:domain,                    MMS.TextValue},
    0x1D => {:path,                      MMS.TextValue},
  }
end
