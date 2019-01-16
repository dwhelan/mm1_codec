defmodule MMS.UnknownAddress do
  use MMS.Address.Base

  def map_address address do
    address |> ok_if(&is_unknown?/1)
  end

  def unmap_address address do
    address |> ok_if(&is_unknown?/1)
  end

  defp is_unknown? {value, type} do
    is_binary(value) and is_binary(type) and type not in ["PLMN", "IPv4", "IPv6"]
  end

  defp is_unknown? _ do
    false
  end
end
