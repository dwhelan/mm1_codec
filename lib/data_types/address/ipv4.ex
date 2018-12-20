defmodule MMS.Address.IPv4 do
  import MMS.OkError

  def map string do
    case string |> to_charlist |> :inet.parse_ipv4_address do
      {:ok, ipv4} -> ok ipv4
      _           -> error :invalid_ipv4_address
    end
  end

  def unmap value do
    (value |> :inet.ntoa |> to_string) <> "/TYPE=IPv4"
  end
end
