defmodule MMS.Codec2Test do
  use MMS.CodecTest
  use MMS.Codec
  alias MMS.CodecTest.{Ok, Error}

  describe "nest_error" do
    test "should accumulate nested error list" do
      assert nest_error({:data_type, :value, [:data_type2, :reason]}) == [:data_type, :data_type2, :reason]
    end

    test "should accumulate nested error" do
      assert nest_error({:data_type, :value, :reason}) == [:data_type, :reason]
    end

    test "should accumulate plain value" do
      assert nest_error(:reason) == :reason
    end
  end

  describe "decode_either should" do
    test "return ok if first codec ok" do
      assert decode_either(<<0>>, [Ok, Error], :codec2_test) == ok(0, "")
      assert decode_either(<<0>>, [Ok, Error]) == ok(0, "")
    end

    test "return ok if subsequent codec ok" do
      assert decode_either(<<0>>, [Error, Ok], :codec2_test) == ok(0, "")
      assert decode_either(<<0>>, [Error, Ok]) == ok(0, "")
    end

    test "return error if all codecs fail" do
      assert decode_either(<<0>>, [Error, Error], :codec2_test) == error(:codec2_test, <<0>>, [data_type: :reason, data_type: :reason])
      assert decode_either(<<0>>, [Error, Error]) == error(:codec2_test, <<0>>, [data_type: :reason, data_type: :reason])
    end
  end
end
