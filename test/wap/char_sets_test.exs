defmodule WAP.CharSetsTest do
  import WAP.CharSets

  use ExUnit.Case

  test "code(name)" do
    assert code(:other)     ===    1
    assert code(:csUTF8)    ===  106
    assert code(:csUnicode) === 1000
    assert code(9999)       === 9999
    assert code(nil)        ===  nil
  end

  test "name(code)" do
    assert map(1)    === :other
    assert map(106)  === :csUTF8
    assert map(1000) === :csUnicode
    assert map(9999) === 9999
    assert map(nil)  === nil
  end
end
