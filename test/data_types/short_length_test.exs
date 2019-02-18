defmodule MMS.ShortLengthTest do
  use MMS.CodecTest

  @thirty_chars String.duplicate("a", 30)

  import MMS.ShortLength

  # Cannot use TestExamples because it assumes all bytes specified will be consumed.

  describe "decode" do
    test "decode with no bytes" do
      assert decode(<<>>) == error :invalid_short_length, <<>>, :no_bytes
    end

    test "decode a short length with sufficient bytes" do
      assert decode(<<0,  "rest">>)        == ok 0,  "rest"
      assert decode(<<1,  "rest">>)        == ok 1,  "rest"
      assert decode(<<30, @thirty_chars>>) == ok 30, @thirty_chars
    end

    test "decode a short length with insufficient bytes" do
      assert decode(<<5, "rest">>) == error :invalid_short_length, <<5, "rest">>, %{length: 5, available_bytes: 4}
    end

    test "decode a non short length" do
      assert decode(<<31, "rest">>) == error :invalid_short_length, <<31, "rest">>, %{out_of_range: 31}
    end
  end

  describe "encode" do
    test "encode a short length" do
      assert encode(1)  == ok <<1>>
      assert encode(30) == ok <<30>>
    end

    test "encode a non short length" do
      assert encode(31) == error :invalid_short_length, 31, :out_of_range
    end
  end
end
