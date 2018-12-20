defmodule MMS.ComposerTest do
  use ExUnit.Case
  alias MMS.{Composer, ShortLength}

  import MMS.OkError
  import Composer

  describe "decode" do
    test "single codec" do
      assert decode(<<1, 2, "rest">>, {ShortLength}) == ok {2}, <<"rest">>
    end

    test "multiple codecs" do
      assert decode(<<2, 3, 4, "rest">>, {ShortLength, ShortLength}) == ok {3, 4}, <<"rest">>
    end

    test "invalid length" do
      assert decode(<<32, 2>>, {ShortLength}) == error :first_byte_must_be_less_than_32
    end

    test "incorrect length" do
      assert decode(<<2, 3>>, {ShortLength}) == error :incorrect_length
    end

    test "error with first value" do
      assert decode(<<1, 255>>, {ShortLength}) == error :must_be_an_integer_between_1_and_30
    end

    test "error with subsequent values" do
      assert decode(<<2, 3, 255>>, {ShortLength, ShortLength}) == error :must_be_an_integer_between_1_and_30
    end

    test "partial results when number of bytes consumed == length" do
      assert decode(<<1, 2>>, {ShortLength, ShortLength}) == ok {2}, <<>>
    end
  end

  describe "encode" do
    test "single value and codec" do
      assert encode({2}, {ShortLength}) == ok <<1, 2,>>
    end

    test "multiple values and codecs" do
      assert encode({3, 4}, {ShortLength, ShortLength}) == ok <<2, 3, 4>>
    end

    test "more values than codecs should ignore extra values" do
      assert encode({3, 4, 5}, {ShortLength, ShortLength}) == ok <<2, 3, 4>>
    end

    test "more codecs than values should ignore extra codecs" do
      assert encode({3, 4}, {ShortLength, ShortLength, ShortLength}) == ok <<2, 3, 4>>
    end

    test "first value invalid" do
      assert encode({0}, {ShortLength}) == error :must_be_an_integer_between_1_and_30
    end

    test "subsequent value invalid" do
      assert encode({1, 0}, {ShortLength, ShortLength}) == error :must_be_an_integer_between_1_and_30
    end

    test "no values" do
      assert encode({}, {ShortLength}) == error :must_provide_at_least_one_value_and_codec
    end

    test "no codecs" do
      assert encode({2}, {}) == error :must_provide_at_least_one_value_and_codec
    end
  end
end
