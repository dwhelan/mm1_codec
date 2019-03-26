defmodule MMS.TypedValueTest do
  use MMS.CodecTest
  import MMS.TypedValue
  alias MMS.{CompactValue, TextValue}
  alias MMS.CodecTest.{Ok, Error}

  describe "decode/2 should" do
    test "return value if it can be decoded as the expected type" do
      assert decode(<< 1 >>, :q) == ok {:q, "00"}, ""
    end

    test "return decoded Text-value if it cannot be decoded as the expected type" do
      assert decode(<< 0 >>, :q) == ok(:no_value, "")
    end

    test "return decoded Text-value even if token is no recognized" do
      assert decode(<< 0 >>, :a) == ok(:no_value, "")
    end

    test "return error if it cannot be decoded as the expected type or Text-value" do
      assert decode(<<1, "rest">>, Error) == error :typed_value, <<1, "rest">>, %{cannot_be_decoded_as: [CompactValue, TextValue]}
    end
  end

  describe "encode/2 should" do
    test "return value bytes if it can be encoded as the expected type" do
      assert encode({:q, "00"}) == ok << 1 >>
    end

    test "encode as a Text-value if it cannot be encoded as the expected type" do
      assert encode({:q, "a"}) == ok << "a\0" >>
    end

    test "return encoded Text-value if token is not recognized" do
      assert encode({:a, :no_value}) == ok << 0 >>
    end

    test "return encode string version of value if value if not a string" do
      assert encode({:q, :a}) == ok << "a\0" >>
    end
  end
end
