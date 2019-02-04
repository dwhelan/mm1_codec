defmodule MMS.EitherTest do
  use MMS.Test2

  use MMS.Either, [MMS.Short, MMS.Text]

  use MMS.TestExamples,
    examples: [
      { << s(0) >>, 0      }, # short
      { "text\0",   "text" }, # text
    ],

    decode_errors: [
      <<>>,
    ],

    encode_errors: [
      :neither,
    ]

  test "raise if no types provided" do
    assert_code_raise "use MMS.Either"
  end

  test "raise if empty types provided" do
    assert_code_raise "use MMS.Either, []"
  end

  test "raise if keyword list provided" do
    assert_code_raise "use MMS.Either, keyword: value"
  end
end
