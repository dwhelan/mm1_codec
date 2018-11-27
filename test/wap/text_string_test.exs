defmodule WAP.TextStringTest do
  use ExUnit.Case

  use MM1.BaseDecoderExamples, codec: WAP.TextString,
    examples: [
      {<<0>>,             ""},
      {<<"text", 0>>, "text"},
    ],

    decode_errors: [
      {<<"text">>, :missing_terminator, "text"}
    ]
end
