defmodule MMS.ListTest do
  use MMS.Test

  import MMS.List

end
defmodule MMS.ListUseTest do
  use MMS.Test

  use MMS.List, codecs: [MMS.Short, MMS.Text]

  use MMS.TestExamples,

    examples: [
      { << s(0), "x\0" >>, [0, "x"] }
    ]

  test "raise if no types provided" do
    assert_code_raise "use MMS.List"
  end

  test "raise if empty types provided" do
    assert_code_raise "use MMS.List, []"
  end

  test "raise if keyword list provided" do
    assert_code_raise "use MMS.List, keyword: value"
  end
end
