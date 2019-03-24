defmodule MMS.TypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-parameter = Well-known-parameter-token Typed-value
  Well-known-parameter-token = Integer-value

  The actual expected type of the value is implied by the well-known parameter

  Table 38. Well-Known Parameter Assignments

  |Token            |Assigned Number |BNF Value Rule      |
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

  Note: * These numbers have been deprecated and should not be used.

  """

  alias MMS.{WellKnownCharset, DateValue, IntegerValue, MediaType, NoValue, QValue, ShortInteger, TextString, TextValue, Version}

  alias MediaType,      as: ConstrainedEncoding
  alias IntegerValue,    as: DeltaSecondsValue
  alias TextString, as: FieldName

  use MMS.CodecMapper,
      values: [
        q:                     QValue,
        charset:               WellKnownCharset,
        level:                 Version,
        type:                  IntegerValue,
        _unassigned:           nil,
        name_deprecated:       TextString,
        file_name_deprecated:  TextString,
        differences:           FieldName,
        padding:               ShortInteger,
        type_multipart:        ConstrainedEncoding,
        start_deprecated:      TextString,
        start_info_deprecated: TextString,
        comment_deprecated:    TextString,
        domain_deprecated:     TextString,
        max_age:               DeltaSecondsValue,
        path_deprecated:       TextString,
        secure:                NoValue,
        sec:                   ShortInteger,
        mac:                   TextValue,
        creation_date:         DateValue,
        modification_date:     DateValue,
        read_date:             DateValue,
        size:                  IntegerValue,
        name:                  TextValue,
        file_name:             TextValue,
        start:                 TextValue,
        start_info:            TextValue,
        comment:               TextValue,
        domain:                TextValue,
        path:                  TextValue,
      ],
      error: :known_parameter
end
