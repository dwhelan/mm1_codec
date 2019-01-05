defmodule MMS.EitherTest do
  use MMS.Test

  use MMS.Either, [MMS.Short, MMS.Text]

  use MMS.TestExamples,
    examples: [
      { << s(0) >>, 0 },
      { "text\0", "text" },
    ],

    decode_errors: [
      { <<>>, :invalid_either_test},
    ],

    encode_errors: [
      { :not_either, :invalid_either_test },
      { 128,         :invalid_either_test },
    ]

  test "raise if no types provided" do
    assert_code_error "use MMS.Either"
  end

  test "raise if empty types provided" do
    assert_code_error "use MMS.Either, []"
  end

  test "raise if keyword list provided" do
    assert_code_error "use MMS.Either, keyword: value"
  end

end
