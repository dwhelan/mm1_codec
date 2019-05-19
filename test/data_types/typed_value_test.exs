defmodule MMS.TypedValueTest do
  use MMS.CodecTest
  import MMS.TypedValue

  alias MMS.ShortInteger

#  def decode bytes do
#    bytes
#    |> decode(ShortInteger)
#  end

  describe "decode/2 should" do
    test "return value if it can be decoded as the expected type" do
      assert decode(<< s 0 >>, ShortInteger) == ok 0, ""
    end

    test "return decoded Text-value if it cannot be decoded as the expected type" do
      assert decode(<< "a\0" >>, ShortInteger) == ok "a", ""
    end

    test "return :no_value when first octet is 0" do
      assert decode(<< 0 >>, ShortInteger) == ok :no_value, ""
    end

    test "return error if it cannot be decoded as the expected type or Text-value" do
      assert {:error, {:typed_value, <<1>>, _}}= decode(<<1>>, ShortInteger)
    end
  end

  describe "encode/2 should" do
    test "return value bytes if it can be encoded as the expected type" do
      assert encode(0, ShortInteger) == ok << s 0 >>
    end

    test "encode as a Text-value if it cannot be encoded as the expected type" do
      assert encode("a", ShortInteger) == ok << "a\0" >>
    end

    test "return encode 0 if value is :no_value" do
      assert encode(:no_value, ShortInteger) == ok << 0 >>
    end

    test "return error if value is not of the expected type or a string" do
      assert {:error, {:typed_value, :bad_value, _}}= encode(:bad_value, ShortInteger)
    end
  end
end
