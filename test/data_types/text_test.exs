defmodule MMS.TextTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Text,
      examples: [
        {<<0>>,         {    "", <<>>}},
        {<<"text", 0>>, {"text", <<>>}},
      ],

      decode_errors: [
        {<<"text">>, :missing_terminator},
      ]
end
