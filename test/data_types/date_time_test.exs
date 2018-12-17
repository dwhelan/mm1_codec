defmodule MMS.DateTimeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.DateTime,
      examples: [
        # short length
        {<<3, 128, 1, 0>>, {0, :absolute, 3}},
        {<<3, 129, 1, 0>>, {0, :relative, 3}},

        # long length
        {<<31, 32, 128, 1, 0>>, {0, :absolute, 32}},
      ],

      decode_errors: [
        {<<32>>,            :first_byte_must_be_less_than_32}, # length error
        {<<3,   0,  1, 0>>, :most_signficant_bit_must_be_1  }, # absolute/relative error
        {<<3, 128, 31, 0>>, :length_must_be_between_1_and_30}, # value error
      ],

      encode_errors: [
        {{:not_long, :absolute,  3}, :must_be_an_integer_between_1_and_30_bytes_long}, # value error
        {{0,         128,        3}, :must_be_an_integer_between_0_and_127          }, # absolute/relative error
        {{0,         :absolute, -1}, :must_be_an_unsigned_32_bit_integer            }, # length error
      ]

  test "encode should calculate length if not provided" do
    assert MMS.DateTime.encode({0, :absolute}) == {:ok, <<3, 128, 1, 0>>}
  end

  test "encode %DateTime should use Unix seconds, absolute" do
    assert MMS.DateTime.encode(DateTime.from_unix! 0) == {:ok, <<3, 128, 1, 0>>}
  end

  test "encode integer should use integer value, absolute" do
    assert MMS.DateTime.encode(0) == {:ok, <<3, 128, 1, 0>>}
  end
end

