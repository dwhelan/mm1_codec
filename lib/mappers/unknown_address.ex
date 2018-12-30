defmodule MMS.UnknownAddress do
  use MMS.Address.Base, type: "", error: :invalid_unknown_address
  import MMS.OkError

  def map_address {string, type} do
    check {string, type}
  end

  def unmap_address({string, type}) when is_binary(string) and is_binary(type) do
    check {string, type}
  end

  def unmap_address _ do
    error()
  end

  defp check {value, type} do
    if is_binary(value) and is_binary(type) and type not in ["PLMN", "IPv4", "IPv6"] do
      ok {value, type}
    else
      error
    end
  end
end
