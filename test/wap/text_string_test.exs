defmodule WAP.TextStringTest do
  use ExUnit.Case

  use MM1.Codecs.TestExamples, codec: WAP.TextString,
    examples: [
      {<<0>>,             ""},
      {<<"text", 0>>, "text"},
    ],

    decode_errors: [
      {<<"text">>, :missing_terminator, "text", <<"text">>}
    ]
end

defmodule WAP2.TextStringTest do
  use ExUnit.Case

  use MM1.Codecs2.TestExamples,
      codec: WAP2.TextString,
      examples: [
        {<<0>>,         {    "", <<>>}},
        {<<"text", 0>>, {"text", <<>>}},
      ],

      decode_errors: [
        {<<"text">>, :missing_terminator},
      ]
end
