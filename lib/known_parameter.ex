defmodule MMS.KnownParameter do
  # Based on WAP-230-WSP-20010705-a: Table 38. Well-Known Parameter Assignments

  alias MMS.{Charset, DateTime, Integer, Media, NoValue, QValue, Short, TextString, TextValue, Version}

  alias Media,      as: ConstrainedEncoding
  alias Integer,    as: DeltaSecondsValue
  alias TextString, as: FieldName

  use MMS.CodecMapper,
      values: [
        q:                     QValue,
        charset:               Charset,
        level:                 Version,
        type:                  Integer,
        _unassigned:           nil,
        name_deprecated:       TextString,
        file_name_deprecated:  TextString,
        differences:           FieldName,
        padding:               Short,
        type_multipart:        ConstrainedEncoding,
        start_deprecated:      TextString,
        start_info_deprecated: TextString,
        comment_deprecated:    TextString,
        domain_deprecated:     TextString,
        max_age:               DeltaSecondsValue,
        path_deprecated:       TextString,
        secure:                NoValue,
        sec:                   Short,
        mac:                   TextValue,
        creation_date:         DateTime,
        modification_date:     DateTime,
        read_date:             DateTime,
        size:                  Integer,
        name:                  TextValue,
        file_name:             TextValue,
        start:                 TextValue,
        start_info:            TextValue,
        comment:               TextValue,
        domain:                TextValue,
        path:                  TextValue,
      ],
      error: :invalid_known_parameter
end
