defmodule MMS.EncodedStringTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.EncodedString,
      examples: [
        # Not encoded
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},

        # Encoded
        {<<6, 0xea, "string", 0>>,               { 6, :csUTF8,    "string"}},
        {<<8, 2, 0x03, 0xe8, "string", 0>>,      { 8, :csUnicode, "string"}},
        {<<31, 42, 2, 0x03, 0xe8, "string", 0>>, {42, :csUnicode, "string"}},
      ],

      decode_errors: [
        {<<"string">>,          :missing_terminator},
        {<<6, 0xea, "string">>, :missing_terminator},
      ]
end

