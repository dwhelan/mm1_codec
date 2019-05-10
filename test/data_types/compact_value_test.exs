defmodule MMS.CompactValueTest do
  use MMS.CodecTest

  import MMS.CompactValue

  describe "decode/2" do
    test "when bytes and token are valid" do
      assert decode(<< 1 >>, :q) == ok {:q, "00"}, ""
    end

    test "when token is invalid" do
      assert decode(<< 1 >>, :foo) == error :compact_value, << 1 >>, invalid_token: :foo
    end

    test "when bytes are invalid" do
      assert {:error, {:compact_value, << 0 >>, _}} = decode(<< 0 >>, :q)
    end
  end

  describe "encode/2" do
    test "when value and token are valid" do
      assert encode({:q, "00"}) == ok << 1 >>
    end

    test "when token is invalid" do
      assert encode({:foo, "00"}) == error :compact_value, {:foo, "00"}, invalid_token: :foo
    end

    test "when value is invalid" do
      assert {:error, {:compact_value, {:q, ""}, _}} = encode({:q, ""})
    end
  end
end
