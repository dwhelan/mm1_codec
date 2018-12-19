defmodule MMS.ComposerTest do
  use ExUnit.Case
  import MMS.OkError

  alias MMS.{Composer, ShortLength}
  import Composer

  describe "decode" do
    test "single codec" do
      assert decode(<<1, 2>>, {ShortLength}) == ok {2}, <<>>
    end

    test "multiple codecs" do
      assert decode(<<2, 3, 4>>, {ShortLength, ShortLength}) == ok {3, 4}, <<>>
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
  end
end
