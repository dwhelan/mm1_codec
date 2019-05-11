defmodule MMS.QValue.Test do
  use MMS.CodecTest
  import MMS.QValue

  codec_examples [
    {"1",    u(1),    "00"},
    {"100",  u(100),  "99"},
    {"101",  u(101),  "001"},
    {"1099", u(1099), "999"},
  ]

  decode_errors [
    {"<<>>", <<>>},
    {"0", u(0), out_of_range: 0},
    {"1100", u(1100), out_of_range: 1100},
  ]

  encode_errors [
    {"0", "0"},
    {"1100", "1100", :must_be_string_of_2_or_3_digits},
  ]

  describe "encode" do
    test "00",  do: assert encode("00")  == ok u(1)
    test "99",  do: assert encode("99")  == ok u(100)
    test "001", do: assert encode("001") == ok u(101)
    test "999", do: assert encode("999") == ok u(1099)

    test "0",    do: assert encode("0")    == error :qvalue, "0",    :must_be_string_of_2_or_3_digits
    test "1000", do: assert encode("1000") == error :qvalue, "1000", :must_be_string_of_2_or_3_digits
    test "ab",   do: assert encode("ab")   == error :qvalue, "ab",   :must_be_string_of_2_or_3_digits
    test "abc",  do: assert encode("abc")  == error :qvalue, "abc",  :must_be_string_of_2_or_3_digits
  end
end
