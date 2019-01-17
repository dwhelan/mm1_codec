defmodule Codec.StringTest do
  use ExUnit.Case

  import Codec.String

  test "pascalcase/1" do
    assert pascalcase("")      == ""
    assert pascalcase("1")     == "1"
    assert pascalcase("a")     == "A"
    assert pascalcase("A")     == "A"
    assert pascalcase("AB")    == "Ab"
    assert pascalcase("ABC")   == "Abc"
    assert pascalcase("AB1C2") == "Ab1C2"
    assert pascalcase("Ab1C2") == "Ab1C2"
    assert pascalcase("A1bC2") == "A1bC2"
  end

  test "append/1" do
    assert append("a", "b") == "ab"
  end

  test "prepend/1" do
    assert prepend("a", "b") == "ba"
  end
end
