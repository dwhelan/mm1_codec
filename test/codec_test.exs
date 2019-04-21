defmodule MMS.Codec2Test do
  use MMS.CodecTest
  use MMS.Codec

  describe "data_type/1 should" do
    test "convert all upper case letters to lower case" do
      assert data_type(A)     == :a
      assert data_type(AB)    == :ab
      assert data_type(ABC)   == :abc
    end

    test "should combine an uppercase with following characters until the next uppercase is found" do
      assert data_type(Ab1C2) == :ab1_c2
      assert data_type(AB1C2) == :ab1_c2
    end
  end

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

  test "default encode" do
    assert encode(:bad) == error :bad, :bad_data_type
  end
end
