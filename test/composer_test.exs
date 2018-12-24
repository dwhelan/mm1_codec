defmodule MMS.ComposerTest do
  use ExUnit.Case
  alias MMS.{Composer, ShortLength, Byte}

  import MMS.OkError
  import Composer

  describe "decode" do
    test "single codec" do
      assert decode(<<1, 2, "rest">>, [ShortLength]) == ok [2], <<"rest">>
    end

    test "multiple codecs" do
      assert decode(<<2, 3, 4, "rest">>, [ShortLength, ShortLength]) == ok [3, 4], <<"rest">>
    end

    test "ok when bytes consumed before all codecs" do
      assert decode(<<1, 2>>, [ShortLength, ShortLength]) == ok [2], <<>>
    end

    test "use last codec until length consumed" do
      assert decode(<<3, 1, 32, 33>>, [ShortLength, Byte]) == ok [1, 32, 33], <<>>
    end

    test "invalid length" do
      assert decode(<<32, 2>>, [ShortLength]) == error :invalid_length
    end

    test "incorrect length" do
      assert decode(<<2, 3>>, [ShortLength]) == error :incorrect_length
    end

    test "error with first value" do
      assert decode(<<1, 255>>, [ShortLength]) == error :invalid_short_length
    end

    test "error with subsequent values" do
      assert decode(<<2, 3, 255>>, [ShortLength, ShortLength]) == error :invalid_short_length
    end
  end

  describe "encode" do
    test "single value and codec" do
      assert encode([2], [ShortLength]) == ok <<1, 2,>>
    end

    test "multiple values and codecs" do
      assert encode([3, 4], [ShortLength, ShortLength]) == ok <<2, 3, 4>>
    end

    test "more values than codecs should ignore extra values" do
      assert encode([3, 4, 5], [ShortLength, ShortLength]) == ok <<2, 3, 4>>
    end

    test "more codecs than values should ignore extra codecs" do
      assert encode([3, 4], [ShortLength, ShortLength, ShortLength]) == ok <<2, 3, 4>>
    end

    test "first value invalid" do
      assert encode([0], [ShortLength]) == error :invalid_short_length
    end

    test "subsequent value invalid" do
      assert encode([1, 0], [ShortLength, ShortLength]) == error :invalid_short_length
    end

    test "[] -> <<>>" do
      assert encode([], []) == ok <<>>
    end
  end
end
