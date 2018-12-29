defmodule MMS.Address.Unknown do
  import MMS.OkError

  def map value, type do
     ok {value, type}
  end

  def unmap {value, type} do
    ok value <> "/TYPE=#{type}"
  end

  def is_unknown? value do
    is_binary(value) and String.contains?(value, "/TYPE=")
  end
end
