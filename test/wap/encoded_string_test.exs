defmodule WAP.EncodedStringTest do
  use ExUnit.Case

  use MM1.Codecs.BaseExamples, codec: WAP.EncodedString,
    examples: [
      {<<0>>,                                ""},
      {<<"text", 0>>,                        "text"},
      {<<6, 0xea, "text", 0>>,               { 6, :csUTF8,    "text"}},
      {<<8, 2, 0x03, 0xe8, "text", 0>>,      { 8, :csUnicode, "text"}},
      {<<31, 42, 2, 0x03, 0xe8, "text", 0>>, {42, :csUnicode, "text"}},
    ],

    decode_errors: [
      {<<"text">>,          :missing_terminator, "text"},
      {<<6, 0xea, "text">>, :missing_terminator, {6, :csUTF8, "text"}},
    ]
end
