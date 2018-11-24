defmodule WAP.EncodedStringTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.EncodedString

  examples EncodedString, [
    {"no encoding",                       <<"text", 0>>,                        "text"},
    {"UTF8 encoding (1 byte charset)",    <<6, 0xea, "text", 0>>,               { 6, :csUTF8,    "text"}},
    {"Unicode encoding (3 byte charset)", <<8, 2, 0x03, 0xe8, "text", 0>>,      { 8, :csUnicode, "text"}},
    {"Long value length",                 <<31, 42, 2, 0x03, 0xe8, "text", 0>>, {42, :csUnicode, "text"}},
  ]

  test "no terminator" do
    assert %{value: {:err, :missing_terminator}, bytes: <<>>, rest: <<"text">> } = EncodedString.decode <<"text">>
  end
end
