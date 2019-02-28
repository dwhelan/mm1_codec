defmodule MMS.ShortLengthTest do
  use MMS.CodecTest

  @thirty_chars String.duplicate("a", 30)

  import MMS.ShortLength

  # Cannot use TestExamples because it assumes all bytes specified will be consumed.

  describe "decode" do
    test "decode with no bytes" do
      assert decode(<<>>) == error :short_length, <<>>, :no_bytes
    end

    test "decode a short length with sufficient bytes" do
      assert decode(<<0,  "rest">>)        == ok 0,  "rest"
      assert decode(<<1,  "rest">>)        == ok 1,  "rest"
      assert decode(<<30, @thirty_chars>>) == ok 30, @thirty_chars
    end

    test "decode a short length with insufficient bytes" do
      assert decode(<<5, "rest">>) == error :short_length, <<5, "rest">>, %{short_length: 5, available_bytes: 4}
    end

    test "decode a non short length" do
      assert decode(<<invalid_short_length()>>) == error :short_length, <<invalid_short_length()>>, %{out_of_range: invalid_short_length()}
    end
  end

  describe "encode" do
    test "encode a short length" do
      assert encode(0) == ok <<0>>
      assert encode(max_short_length()) == ok <<max_short_length()>>
    end

    test "encode a non short length" do
      assert encode(invalid_short_length()) == error :short_length, invalid_short_length(), :out_of_range
    end
  end
end
