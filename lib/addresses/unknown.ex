defmodule MMS.Address.Unknown do
  use MMS.Address.Base, type: "", error: :invalid_unknown_address
  import MMS.OkError

  def map_address {string, type} do
    ok {string, type}
  end

  def unmap_address({string, type}) when is_binary(string) and is_binary(type) do
    ok {string, type}
  end

  def unmap_address _ do
    error()
  end
end
