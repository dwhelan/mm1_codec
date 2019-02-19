defmodule MMS.ComposerTest do
  use MMS.CodecTest

  alias MMS.{Composer, Byte, Short}

  import Composer

  describe "decode" do
    test "single codec" do
      assert decode(<<l(1), 2, "rest">>, [Byte]) == ok {2}, <<"rest">>
    end

    test "multiple codecs" do
      assert decode(<<l(2), 3, 4, "rest">>, [Byte, Byte]) == ok {4, 3}, <<"rest">>
    end

    test "ok when bytes consumed before all codecs" do
      assert decode(<<l(1), 2>>, [Byte, Byte]) == ok {2}, <<>>
    end

    test "use last codec until length consumed" do
      assert decode(<<l(3), 1, 2, 3>>, [Byte]) == ok {3, 2, 1}, <<>>
    end

    test "length > 31" do
      assert decode(<<l(32)>>, [Byte]) == error {:value_length, " ", :does_not_start_with_a_short_length_or_length_quote}
    end

    test "incorrect length" do
      assert decode(<<l(2), 3>>, [Byte]) == error {:short_length, <<2, 3>>, %{available_bytes: 1, length: 2}}
    end

    test "error with first value" do
      assert decode(<<l(1), 0>>, [Short]) == error :short
    end

    test "error with subsequent values" do
      assert decode(<<l(2), 0, 0>>, [Byte, Short]) == error :short
    end
  end

  describe "encode" do
    test "single value and codec" do
      assert encode([2], [Byte]) == ok << l(1), 2 >>
    end

    test "multiple values and codecs" do
      assert encode([3, 4], [Byte, Byte]) == ok << l(2), 3, 4 >>
    end

    test "more values than codecs should ignore extra values" do
      assert encode([3, 4, 5], [Byte, Byte]) == ok << l(2), 3, 4 >>
    end

    test "more codecs than values should ignore extra codecs" do
      assert encode([3, 4], [Byte, Byte, Byte]) == ok << l(2), 3, 4 >>
    end

    test "first value invalid" do
      assert encode([256], [Byte]) == error {:byte, 256, :out_of_range}
    end

    test "subsequent value invalid" do
      assert encode([0, 256], [Byte, Byte]) == error {:byte, 256, :out_of_range}
    end

    test "[] -> <<>>" do
      assert encode([], []) == ok <<>>
    end
  end
end
