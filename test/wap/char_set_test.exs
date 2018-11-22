defmodule WAP.CharSetTest do
  alias WAP.CharSet
  alias MM1.Result

  import CharSet
  use MM1.CodecTest
#      codec: CharSet,
#      transforms: [
#        # As a Short-integer
#        { <<0x81>>,   [name: :other,  code:   1] },
#        { <<0xEA>>,   [name: :csUTF8, code: 106] },
#
#        # As a Long-integer
#        { <<2, 0x03, 0xe8>>, [name: :csUnicode, code: 1000] },
#        { <<2, 0x0b, 0xb8>>, [name: :reserved,  code: 3000] },
#      ],
#      decode_errors: [
#        { <<0>>,  :length_cannot_be_zero  },
#        { <<31>>, :length_greater_than_30 },
#      ]
  def bytes do
    <<0x81, "rest">>
  end

  def result do
    %Result{module: CharSet, value: :other, bytes: <<0x81>>, rest: <<"rest">>}
  end

  describe "decode" do
#    test "UTF8", do: assert decode(<<0xea>>).value === :csUTF8
  end
#  test "char_set_size" do
#    assert CharSet.size(0)      === 1
#    assert CharSet.size(127)    === 1
#    assert CharSet.size(128)    === 3
#    assert CharSet.size(65_535) === 3
#  end
end
