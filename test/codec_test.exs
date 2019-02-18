defmodule MMS.Codec2Test do
  use MMS.CodecTest

  describe "error_detail_list" do
    test "should remove value" do
      assert error_detail_list({:code, :value, :reason}) == [:code, :reason]
    end

    test "should apply recursively" do
      assert error_detail_list({:code, :value, {:code2, :value2, :reason2}}) == [:code, :code2, :reason2]
    end
  end
end
