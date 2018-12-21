defmodule MMS.ContentTypeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ContentType,
      examples: [
        {<<0x80>>, "*/*"}
      ],

      decode_errors: [
        {<<"x">>, :missing_terminator}, # constrained media error
      ]
end
