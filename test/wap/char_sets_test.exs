defmodule WAP.CharSetsTest do
  import WAP.CharSets

  use ExUnit.Case

  test "lookup(atom)" do
    assert lookup(:other)   === [ name: :other,   code:    1 ]
    assert lookup(:csUTF8)  === [ name: :csUTF8,  code:  106 ]
    assert lookup(:cs50220) === [ name: :cs50220, code: 2260 ]
    assert lookup(:foo)     === [ name: :foo    , code:  nil ]
  end

  test "lookup(code)" do
    assert lookup(1)    === [ name: :other,   code:    1 ]
    assert lookup(106)  === [ name: :csUTF8,  code:  106 ]
    assert lookup(2260) === [ name: :cs50220, code: 2260 ]
    assert lookup(9999) === [ name: nil,      code: 9999 ]
  end

  test "lookup(nil)" do
    assert lookup(nil)  === [ name: nil, code:  nil ]
  end
end
