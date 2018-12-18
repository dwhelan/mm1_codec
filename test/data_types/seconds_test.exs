defmodule MMS.SecondsTest do
  use ExUnit.Case

  alias MMS.Seconds

  use MMS.TestExamples,
      codec: Seconds,
      examples: [
        # short length
        {<<3, 128, 1, 0>>, {DateTime.from_unix!(0), 3}},
        {<<3, 129, 1, 0>>, {0                     , 3}},

        # long length
        {<<31, 32, 128, 1, 0>>, {DateTime.from_unix!(0), 32}},
      ],

      decode_errors: [
        {<<32>>,            :first_byte_must_be_less_than_32}, # length error
        {<<3,   0,  1, 0>>, :most_signficant_bit_must_be_1  }, # absolute/relative error
        {<<3, 128, 31, 0>>, :length_must_be_between_1_and_30}, # value error
      ],

      encode_errors: [
        {{:not_long,  3}, :must_be_an_integer_between_1_and_30_bytes_long}, # value error
        {{0,         -1}, :must_be_an_unsigned_32_bit_integer            }, # length error
      ]

#      test "decode() with long length"
#  test "encode({value, absolute}) should calculate length" do
#    assert Seconds.encode({0, :absolute}) == {:ok, <<3, 128, 1, 0>>}
#  end

  test "encode(%DateTime{}) should use Unix seconds, absolute" do
    assert Seconds.encode({DateTime.from_unix!(0), 3}) == {:ok, <<3, 128, 1, 0>>}
  end

  test "encode(integer) should use integer value, relative" do
    assert Seconds.encode({0, 3}) == {:ok, <<3, 129, 1, 0>>}
  end
end

