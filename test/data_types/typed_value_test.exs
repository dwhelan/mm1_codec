defmodule MMS.TypedValueTest do
  use MMS.CodecTest
  import MMS.TypedValue
  alias MMS.CodecTest.{Ok, Error}

  describe "decode/2 should" do
    test "return Compact-value if it can be decoded as the expected type" do
      assert decode(<<0, "rest">>, Ok) == ok(0, "rest")
    end

    test "return Text-value if it cannot be decoded as the expected type" do
      assert decode(<<"a\0", "rest">>, Error) == ok("a", "rest")
    end

    test "return error if it cannot be decoded as the expected type or Text-value" do
      assert decode(<<1, "rest">>, Error) == error :typed_value, <<1, "rest">>, %{cannot_be_decoded_as: [Error, MMS.TextValue]}
    end
  end
end
