defmodule MMS.Address.Unknown do
  import MMS.OkError

  def map string do
     ok string
  end

  def unmap value do
    value
  end

  def is_unknown? value do
    is_binary(value) and String.contains?(value, "/TYPE=")
  end
end
