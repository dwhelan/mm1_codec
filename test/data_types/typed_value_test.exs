defmodule MMS.TypedValueTest do
  use MMS.CodecTest
  import MMS.{TypedValue}
  alias MMS.CodecTest.{Ok, Error}

  describe "decode/2 should" do
    test "return value if it can be decoded as the expected type" do
      assert decode(<<0, "rest">>, Ok) == ok(0, "rest")
    end

    test "return decoded Text-value if it cannot be decoded as the expected type" do
      assert decode(<<"a\0", "rest">>, Error) == ok("a", "rest")
    end

    test "return error if it cannot be decoded as the expected type or Text-value" do
      assert decode(<<1, "rest">>, Error) == error :typed_value, <<1, "rest">>, %{cannot_be_decoded_as: [Error, MMS.TextValue]}
    end
  end

  describe "encode/2 should" do
    test "return value bytes if it can be encoded as the expected type" do
      assert encode(0, Ok) == ok <<0>>
    end

    test "return encodec Text-value if it cannot be encoded as the expected type" do
      assert encode("a", Error) == ok "a\0"
    end

    test "return error if it cannot be encoded as the expected type or Text-value" do
      assert encode(1, Error) == error :typed_value, 1, %{cannot_be_encoded_as: [Error, MMS.TextValue]}
    end
  end
end
