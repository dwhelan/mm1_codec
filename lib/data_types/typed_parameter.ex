defmodule MMS.TypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-parameter = Well-known-parameter-token Typed-value

  The actual expected type of the value is implied by the well-known parameter

  Table 38. Well-Known Parameter Assignments
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
