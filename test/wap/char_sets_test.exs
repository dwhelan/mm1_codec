defmodule WAP.CharSetsTest do
  import WAP.CharSets
  alias MM1.Result

  use ExUnit.Case

  test "map(result)" do
    assert map(%Result{value: 1}) === %Result{value: :other}
  end

  test "unmap(result)" do
    assert unmap(%Result{value: :other}) === %Result{value: 1}
  end

  test "map(code)" do
    assert map(1)    === :other
    assert map(106)  === :csUTF8
    assert map(1000) === :csUnicode
    assert map(9999) === 9999
    assert map(nil)  === nil
  end

  test "unmap(value)" do
    assert unmap(:other)     ===    1
    assert unmap(:csUTF8)    ===  106
    assert unmap(:csUnicode) === 1000
    assert unmap(9999)       === 9999
    assert unmap(nil)        ===  nil
  end
end

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
