defmodule MMS.Address.IPv4 do
  import MMS.OkError

  def map string do
    case string |> to_charlist |> :inet.parse_ipv4_address do
      {:ok, ipv4} -> ok ipv4
      _           -> error :invalid_ipv4_address
    end
  end

  def unmap(ipv4) when is_tuple(ipv4) and tuple_size(ipv4) == 4  do
    ok (ipv4 |> :inet.ntoa |> to_string) <> "/TYPE=IPv4"
  end

  def unmap _ do
    error :invalid_ipv4_address
  end

  def is_ipv4? value do
    is_tuple(value) and tuple_size(value) == 4
  end
end
