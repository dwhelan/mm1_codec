defmodule WAP.CharSetTest do
  alias WAP.CharSet
  alias MM1.Result

  import CharSet
  use MM1.CodecTest

  def bytes do
    <<0x81, "rest">>
  end

  def result do
    %Result{module: CharSet, value: :other, bytes: <<0x81>>, rest: <<"rest">>}
  end

  describe "decode" do
    test "UTF8",     do: assert decode(<<0xea>>).value          === :csUTF8
    test "Unicode",  do: assert decode(<<2, 0x03, 0xe8>>).value === :csUnicode
    test "Reserced", do: assert decode(<<2, 0x0b, 0xb8>>).value === :reserved
  end

#  test "char_set_size" do
#    assert CharSet.size(0)      === 1
#    assert CharSet.size(127)    === 1
#    assert CharSet.size(128)    === 3
#    assert CharSet.size(65_535) === 3
#  end
end
