defmodule MMS.ByteTest do
  use Codec2Test

  import MMS.Byte

  describe "decode" do
    test "with no bytes" do
      assert decode(<<>>) == error code: :insufficient_bytes, bytes: <<>>
    end

    test "with bytes" do
      assert decode(<<0,   "rest">>) == ok 0,   <<"rest">>
      assert decode(<<255, "rest">>) == ok 255, <<"rest">>
    end
  end

  describe "encode" do
    test "with a byte" do
      assert encode(0)   == ok <<0>>
      assert encode(255) == ok <<255>>
    end

    test "with a non-byte" do
      assert encode(256) == error code: :invalid_byte, value: 256
    end
  end
end
