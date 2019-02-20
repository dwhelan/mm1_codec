defmodule MMS.Codec2Test do
  use MMS.CodecTest

  describe "nest_decode_error" do
    test "should accumulate nested error list" do
      assert nest_decode_error({:data_type, :value, [:data_type2, :reason]}) == [:data_type, :data_type2, :reason]
    end

    test "should accumulate nested error" do
      assert nest_decode_error({:data_type, :value, :reason}) == [:data_type, :reason]
    end

    test "should accumulate plain value" do
      assert nest_decode_error(:reason) == :reason
    end
  end
end
