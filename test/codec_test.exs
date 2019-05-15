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
    test "should create a keyword list using data_type as the key and error details as the value" do
      assert nest_error({:data_type, :value, :details}) == [data_type: :details]
    end

    test "should accumulate nested error list" do
      assert nest_error({:data_type2, :value2, data_type: :details}) == [data_type2: [data_type: :details]]
    end

    test "should accumulate plain value" do
      assert nest_error(:details) == :details
    end
  end

  test "default encode" do
    assert encode(:bad) == error :bad, :bad_data_type
  end

  test "map_value" do
    assert map_value(error(:error), & &1) == error :error
    assert map_value(ok(1, "rest"), & &1) == ok 1, "rest"
    assert map_value(ok(1, ""), & &1 + 1) == ok 2, ""
    assert map_value(ok(1, ""), & ok(&1)) == ok 1, ""
    assert map_value(ok(1, ""), & error(&1)) == error 1
    assert map_value(ok(1, ""), fn _ -> nil end) == error nil
  end
end
