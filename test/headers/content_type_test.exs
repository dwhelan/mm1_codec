defmodule MMS.ContentTypeTest do
  use MMS.Test2

  use MMS.TestExamples,
      codec: MMS.ContentType,

      examples: [
        { << s(0) >>,       "*/*"   }, # constrained media
        { << l(1), s(0) >>, {"*/*"} }, # content general form
      ],

      decode_errors: [
        { :not_content_type, :invalid_content_type },
        { "x",               :invalid_content_type },
      ]
end
