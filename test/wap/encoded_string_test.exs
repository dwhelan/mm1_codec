defmodule WAP.EncodedStringTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias WAP.EncodedString

  examples EncodedString, [
    {<<0>>,                                ""},
    {<<"text", 0>>,                        "text"},
    {<<6, 0xea, "text", 0>>,               { 6, :csUTF8,    "text"}},
    {<<8, 2, 0x03, 0xe8, "text", 0>>,      { 8, :csUnicode, "text"}},
    {<<31, 42, 2, 0x03, 0xe8, "text", 0>>, {42, :csUnicode, "text"}},
  ]

  test "missing terminator with just a TextString" do
    assert EncodedString.decode(<<"text">>) ==
      %MM1.Result{
        module: EncodedString,
        value: "text",
        err: :missing_terminator,
        bytes: "text",
        rest: <<>>
      }
  end
end
