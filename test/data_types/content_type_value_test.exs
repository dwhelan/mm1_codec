defmodule MMS.ContentTypeValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.ContentTypeValue,

      examples: [
        { << s(0) >>,       0   }, # constrained media
        { << l(1), s(0) >>, {"*/*"} }, # content general form
      ],

      decode_errors: [
#        { :not_content_type, :content_type },
#        { "x",               :content_type },
      ]
end
