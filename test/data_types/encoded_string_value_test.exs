defmodule MMS.Composer2Test do
  use MMS.CodecTest

  import MMS.Composer2

  def decode_ok(<<value , rest::binary>>), do: ok {value, rest}
  def decode_error(bytes),                 do: error(:test, bytes, nil)

  @bytes <<1, 2, "rest">>

  describe "decode should" do
    test "return an empty list with no function" do
      assert decode(@bytes, []) == ok [], @bytes
    end

    test "return a single item list with one function" do
      assert decode(@bytes, [&decode_ok/1]) == ok [1], <<2, "rest">>
    end

    test "return a multi-item list with multiple functions" do
      assert decode(@bytes, [&decode_ok/1, &decode_ok/1]) == ok [1, 2], <<"rest">>
    end

    test "return an error if it occurs on first function" do
      assert decode(@bytes, [&decode_error/1, &decode_ok/1]) == error :nested, @bytes, [error(:test, @bytes, nil)]
    end

    test "return an error if it occurs on subsequent functions" do
      assert decode(@bytes, [&decode_ok/1, &decode_error/1]) == error :nested, @bytes, [1, error(:test, <<2, "rest">>, nil)]
    end
  end
end

defmodule MMS.EncodedStringValueTest do
  use MMS.CodecTest

  alias MMS.EncodedStringValue

  use MMS.TestExamples,
      codec: EncodedStringValue,

      examples: [
        { << l(3), s(106), "x\0" >>, {"x", :csUTF8} },
      ],

      decode_errors: [
      ]
end

