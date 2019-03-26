defmodule MMS.TypedValueTest do
  use MMS.CodecTest
  import MMS.TypedValue
  alias MMS.{CompactValue, TextValue}

  describe "decode/2 should" do
    test "return value if it can be decoded as the expected type" do
      assert decode(<< s 0 >>, :padding) == ok {:padding, 0}, ""
    end

    test "return :no_value when first octet is 0" do
      assert decode(<< 0 >>, :padding) == ok {:padding, :no_value}, ""
    end

    test "return decoded Text-value if it cannot be decoded as the expected type" do
      assert decode(<< "a\0" >>, :padding) == ok {:padding, "a"}, ""
    end

    test "return decoded Text-value even if token is no recognized" do
      assert decode(<< 0 >>, :foo) == ok {:foo, :no_value}, ""
    end

    test "return error if it cannot be decoded as the expected type or Text-value" do
      assert decode(<< 1 >>, :padding) == error :typed_value, << 1 >>, %{cannot_be_decoded_as: [CompactValue, TextValue]}
    end
  end

  describe "encode/2 should" do
    test "return value bytes if it can be encoded as the expected type" do
      assert encode({:padding, 0}) == ok << s 0 >>
    end

    test "return encode 0 if value is :no_value" do
      assert encode({:a, :no_value}) == ok << 0 >>
    end

    test "encode as a Text-value if it cannot be encoded as the expected type" do
      assert encode({:padding, "a"}) == ok << "a\0" >>
    end

    test "return error if value is not of the expected type or a string" do
      assert encode({:padding, :a}) == error :typed_value, {:padding, :a}, %{cannot_be_encoded_as: [CompactValue, TextValue]}
    end
  end
end
