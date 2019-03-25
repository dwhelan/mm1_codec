defmodule MMS.WellKnownParameterTokenTest do
  use MMS.CodecTest

  alias MMS.WellKnownParameterToken

  alias MMS.{QValue, WellKnownCharset, VersionValue, IntegerValue, TextString}
  alias MMS.{FieldName, ShortInteger, ConstrainedEncoding, DeltaSecondsValue}
  alias MMS.{NoValue, DateValue, TextValue}

  use MMS.TestExamples,
      codec: WellKnownParameterToken,

      examples: [
        # Input bytes  {Token,                      Codec}
        {<< s(0)  >>, {:q,                         QValue}},
        {<< s(1)  >>, {:charset,                   WellKnownCharset}},
        {<< s(2)  >>, {:level,                     VersionValue}},
        {<< s(3)  >>, {:type,                      IntegerValue}},
        {<< s(5)  >>, {:"name (deprecated)",       TextString}},
        {<< s(6)  >>, {:"file_name (deprecated)",  TextString}},
        {<< s(7)  >>, {:differences,               FieldName}},
        {<< s(8)  >>, {:padding,                   ShortInteger}},
        {<< s(9)  >>, {:type_multipart,            ConstrainedEncoding}},
        {<< s(10) >>, {:"start (deprecated)",      TextString}},
        {<< s(11) >>, {:"start_info (deprecated)", TextString}},
        {<< s(12) >>, {:"comment (deprecated)",    TextString}},
        {<< s(13) >>, {:"domain (deprecated)",     TextString}},
        {<< s(14) >>, {:max_age,                   DeltaSecondsValue}},
        {<< s(15) >>, {:"path (deprecated)",       TextString}},
        {<< s(16) >>, {:secure,                    NoValue}},
        {<< s(17) >>, {:sec,                       ShortInteger}},
        {<< s(18) >>, {:mac,                       TextValue}},
        {<< s(19) >>, {:creation_date,             DateValue}},
        {<< s(20) >>, {:modification_date,         DateValue}},
        {<< s(21) >>, {:read_date,                 DateValue}},
        {<< s(22) >>, {:size,                      IntegerValue }},
        {<< s(23) >>, {:name,                      TextValue }},
        {<< s(24) >>, {:file_name,                 TextValue }},
        {<< s(25) >>, {:start,                     TextValue }},
        {<< s(26) >>, {:start_info,                TextValue }},
        {<< s(27) >>, {:comment,                   TextValue }},
        {<< s(28) >>, {:domain,                    TextValue }},
        {<< s(29) >>, {:path,                      TextValue }},
      ],

      encode_errors: [
#        {[x: ""], {:x, :known_parameter}},
      ]
end
