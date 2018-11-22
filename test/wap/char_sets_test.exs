defmodule WAP.CharSetsTest do
  import WAP.CharSets

  use ExUnit.Case

  test "code(name)" do
    assert code(:other)   ===    1
    assert code(:csUTF8)  ===  106
    assert code(:cs50220) === 2260
    assert code(:foo)     ===  nil
    assert code(nil)      ===  nil
  end

  test "name(code)" do
    assert name(1)    === :other
    assert name(106)  === :csUTF8
    assert name(2260) === :cs50220
    assert name(9999) === nil
    assert name(nil)  === nil
  end
end
