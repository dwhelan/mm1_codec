defmodule CodecErrorTest do
  use ExUnit.Case

  import MMS.DataTypes

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
end
