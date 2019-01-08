defmodule MMS.UnknownAddress do
  use MMS.Address.Base
  import OkError.Module

  def map_address {string, type} do
    ok_if_unknown_address {string, type}
  end

  def unmap_address({string, type}) when is_binary(string) and is_binary(type) do
    ok_if_unknown_address {string, type}
  end

  def unmap_address _ do
    module_error()
  end

  defp ok_if_unknown_address {value, type} do
    if is_binary(value) and is_binary(type) and type not in ["PLMN", "IPv4", "IPv6"] do
      ok {value, type}
    else
      module_error()
    end
  end
end

