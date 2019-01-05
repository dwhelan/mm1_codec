defmodule MMS.EitherTest do
  use MMS.Test

  test "raise if no types provided" do
    assert_code_error "use MMS.Either"
  end

  test "raise if keyword list provided" do
    assert_code_error "use MMS.Either, keyword: value"
  end
end
