defmodule MMS.StringTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.String,
      examples: [
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<"string">>, :missing_terminator},
      ]
end
