defmodule MMS.ModuleTest do
  use MMS.CodecTest
  alias MMS.TestCodecs.{List, ListOk}

  @bytes <<1, 2>>

  require MMS.TestCodecs

  test "MMS.TestCodecs.List" do
    assert List.decode(@bytes) == ok [], @bytes
    assert List.encode([]) == ok <<>>
  end

  test "MMS.TestCodecs.ListOk" do
    assert ListOk.decode(@bytes) == ok [1], <<2>>
    assert ListOk.encode([1]) == ok <<1>>
  end
end
