defmodule MMS.StringTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.String,
      examples: [
        {<<0>>,             ""},
        {<<"text", 0>>, "text"},
      ],

      decode_errors: [
        {<<"text">>, :missing_terminator},
      ]
end
