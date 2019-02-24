defmodule MMS.PrefixTest do
  use MMS.CodecTest

  use MMS.Prefix, prefix: 42, codec: MMS.ShortInteger

  use MMS.TestExamples,
    examples: [
      { << 42, s(0) >>, 0 },
    ],

    decode_errors: [
      << 0, 0 >>,
      << 42, 0 >>,
    ],

    encode_errors: [
      :not_a_short,
    ]

  test "raise if no options provided" do
    assert_code_raise "use MMS.Prefix"
  end

  test "raise if empty types provided" do
    assert_code_raise "use MMS.Prefix, []"
  end
end
