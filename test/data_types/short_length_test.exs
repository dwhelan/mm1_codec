defmodule MMS.ShortLengthTest do
  use MMS.Test2

  import MMS.ShortLength

  describe "decode" do
    test "decode with no bytes" do
      assert decode(<<>>) == error code: :insufficient_bytes, bytes: <<>>
    end

    @thirty_chars String.duplicate("a", 30)

    test "decode a short length with sufficient bytes" do
      assert decode(<<0,  "rest">>)        == ok 0,  "rest"
      assert decode(<<1,  "rest">>)        == ok 1,  "rest"
      assert decode(<<30, @thirty_chars>>) == ok 30, @thirty_chars
    end

    test "decode a short length with insufficient bytes" do
      assert decode(<<5, "rest">>) == error code: :insufficient_bytes_for_short_length, bytes: <<5, "rest">>, value: 5
    end

    test "decode a non short length" do
      assert decode(<<31, "rest">>) == error code: :invalid_short_length, bytes: <<31, "rest">>, value: 31
    end
  end

  describe "encode" do
    test "encode a short length" do
      assert encode(1)  == ok <<1>>
      assert encode(30) == ok <<30>>
    end

    test "encode a non short length" do
      assert encode(31) == error code: :invalid_short_length, value: 31
    end
  end
end

