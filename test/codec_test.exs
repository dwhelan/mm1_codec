defmodule MMS.Codec2Test do
  use MMS.CodecTest

  describe "error_detail_list" do
    test "should remove value" do
      assert error_detail_list({:code, :value, :reason}) == [:code, :reason]
    end
  end
end
