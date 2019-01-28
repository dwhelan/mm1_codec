defmodule MMS.ComposerTest do
  use MMS.Test

  alias MMS.{Composer, Byte, Short}

  import Composer

  describe "decode" do
    test "single codec" do
      assert decode(<<l(1), 2, "rest">>, [Byte.Decode]) == ok {2}, <<"rest">>
    end

    test "multiple codecs" do
      assert decode(<<l(2), 3, 4, "rest">>, [Byte.Decode, Byte.Decode]) == ok {4, 3}, <<"rest">>
    end

    test "ok when bytes consumed before all codecs" do
      assert decode(<<l(1), 2>>, [Byte.Decode, Byte.Decode]) == ok {2}, <<>>
    end

    test "use last codec until length consumed" do
      assert decode(<<l(3), 1, 2, 3>>, [Byte.Decode]) == ok {3, 2, 1}, <<>>
    end

    test "length > 31" do
      assert decode(<<l(32)>>, [Byte.Decode]) == error :invalid_length
    end

    test "incorrect length" do
      assert decode(<<l(2), 3>>, [Byte.Decode]) == error :incorrect_length
    end

    test "error with first value" do
      assert decode(<<l(1), 0>>, [Short]) == error :invalid_short
    end

    test "error with subsequent values" do
      assert decode(<<l(2), 0, 0>>, [Byte.Decode, Short]) == error :invalid_short
    end
  end

  describe "encode" do
    test "single value and codec" do
      assert encode([2], [Byte.Encode]) == ok << l(1), 2 >>
    end

    test "multiple values and codecs" do
      assert encode([3, 4], [Byte.Encode, Byte.Encode]) == ok << l(2), 3, 4 >>
    end

    test "more values than codecs should ignore extra values" do
      assert encode([3, 4, 5], [Byte.Encode, Byte.Encode]) == ok << l(2), 3, 4 >>
    end

    test "more codecs than values should ignore extra codecs" do
      assert encode([3, 4], [Byte.Encode, Byte.Encode, Byte.Encode]) == ok << l(2), 3, 4 >>
    end

    test "first value invalid" do
      assert encode([256], [Byte.Encode]) == error code: :invalid_byte, value: 256
    end

    test "subsequent value invalid" do
      assert encode([0, 256], [Byte.Encode, Byte.Encode]) == error code: :invalid_byte, value: 256
    end

    test "[] -> <<>>" do
      assert encode([], []) == ok <<>>
    end
  end
end
