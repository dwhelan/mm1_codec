defmodule MMS.Mapper.IPv4Address do
  use MMS.Address.Base, type: "IPv4"

  def map_address string do
    string |> to_charlist |> :inet.parse_ipv4strict_address
  end

  def unmap_address(ipv4) when is_tuple(ipv4) and tuple_size(ipv4) == 4 do
    ipv4 |> :inet.ntoa ~> to_string
  end

  def unmap_address _ do
    error()
  end
end
