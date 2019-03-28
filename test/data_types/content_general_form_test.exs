defmodule MMS.ContentGeneralFormTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.ContentGeneralForm,

      examples: [
        { << l(1), s(0) >>, :"*/*" },
      ],

      decode_errors: [
      ]
end
