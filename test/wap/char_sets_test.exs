defmodule WAP2.CharSetsTest do
  import WAP2.CharSets
  alias MM1.Result

  use ExUnit.Case

  test "map() should return charset atom when found" do
    assert map(1) == :other
  end

  test "map() should return input value when not found" do
    assert map(:not_found) == :not_found
  end

  test "unmap(mapped_value) should return charset code when found" do
    assert unmap(:other)     ===    1
    assert unmap(:csUTF8)    ===  106
    assert unmap(:csUnicode) === 1000
    assert unmap(9999)       === 9999
    assert unmap(nil)        ===  nil
  end
end
