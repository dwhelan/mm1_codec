defmodule MMS.Address.Unknown do
  import MMS.OkError

  def map string do
     ok string
  end

  def unmap value do
    value
  end
end
