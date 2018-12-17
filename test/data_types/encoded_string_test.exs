defmodule MMS.EncodedStringTest do
  use ExUnit.Case

  alias MMS.EncodedString

use MMS.TestExamples,
      codec: EncodedString,
      examples: [
        # Not encoded
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},

        # Encoded
        {<< 8, 0xea, "string", 0>>,               {"string", :csUTF8,     8}},
        {<<10, 2, 0x03, 0xe8, "string", 0>>,      {"string", :csUnicode, 10}},
        {<<31, 42, 2, 0x03, 0xe8, "string", 0>>, {"string", :csUnicode, 42}},
      ],

      decode_errors: [
        {<<"string">>,          :missing_terminator},
        {<<6, 0xea, "string">>, :missing_terminator},
      ]

  test "encode should calculate length if not provided" do
    assert EncodedString.encode({"string", :csUTF8}) == {:ok, <<8, 0xea, "string", 0>>}
  end
end

