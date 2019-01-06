defmodule MMS.ListTest do
  use MMS.Test

  alias MMS.{Byte}
  import MMS.List

  describe "decode" do
    test "single codec" do
      assert decode(<<0>>, [Byte]) == ok [0], <<>>
    end

    test "multiple codecs" do
      assert decode(<<0, 1, 2>>, [Byte, Byte, Byte]) == ok [0, 1, 2], <<>>
    end
  end

  describe "encode" do
    test "single codec" do
      assert encode([0], [Byte]) == ok <<0>>
    end

    test "multiple codec" do
      assert encode([0, 1, 2], [Byte, Byte, Byte]) == ok <<0, 1, 2>>
    end
  end
end

defmodule MMS.ListUseTest do
  use MMS.Test

  use MMS.List, [MMS.Short, MMS.Text]

  use MMS.TestExamples,

    examples: [
      { << s(0), "x\0" >>, [0, "x"] }
    ]

  test "raise if no types provided" do
    assert_code_raise "use MMS.List"
  end

  test "raise if keyword list provided" do
    assert_code_raise "use MMS.List, keyword: value"
  end
end
