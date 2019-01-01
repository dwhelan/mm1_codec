defmodule MMS.Mapper.IPv6Address do
  use MMS.Address.Base, type: "IPv6"

  def map_address string do
    string |> String.replace(":", "::") |> to_charlist |> :inet.parse_ipv6strict_address
  end

  def unmap_address(ipv6) when is_tuple(ipv6) and tuple_size(ipv6) == 8 do
    ipv6 |> :inet.ntoa ~> to_string ~> String.replace("::", ":")
  end

  def unmap_address _ do
    error()
  end
end
