defmodule MMS.CompactValueTest do
  use MMS.CodecTest

  import MMS.CompactValue

  describe "decode/2" do
    test "when bytes and token are valid" do
      assert decode(<< 1 >>, :q) == ok {:q, "00"}, ""
    end

    test "when token is valid" do
      assert decode(<< 1 >>, :foo) == error :compact_value, << 1 >>, %{invalid_token: :foo}
    end

    test "when bytes are valid" do
      assert decode(<< 0 >>, :q) == error :compact_value, << 0 >>, [:qvalue, %{out_of_range: 0}]
    end
  end
end
