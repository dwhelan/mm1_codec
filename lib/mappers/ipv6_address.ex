defmodule MMS.Mapper.IPv6Address do
  use MMS.Address.Base, type: "IPv6", error: :invalid_ipv6_address
  import MMS.OkError

  def map_address string do
    string |> String.replace(":", "::") |> to_charlist |> :inet.parse_ipv6strict_address
  end

  def unmap_address(ipv6) when is_tuple(ipv6) and tuple_size(ipv6) == 8 do
    case_ok :inet.ntoa ipv6 do
      charlist -> ok charlist |> to_string |> String.replace("::", ":")
    end
  end

  def unmap_address _ do
    error()
  end
end
