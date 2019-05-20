defmodule MMS.ModuleTest do
  use MMS.CodecTest
  import MMS.Module

  test "name" do
    assert name(MMS.Module, [MMS.Ok]) == MMS.Module.Ok
    assert name(MMS.Module, [MMS.Ok, MMS.Error]) == MMS.Module.OkError
  end
end
