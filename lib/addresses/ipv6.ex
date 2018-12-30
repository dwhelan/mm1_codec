defmodule MMS.Address.IPv6 do
  use MMS.Address.Base, type: "IPv6", error: :invalid_ipv6_address
  import MMS.OkError

  def map_address string do
    string |> to_double_colon |> to_charlist |> :inet.parse_ipv6_address
  end

  def unmap_address(ipv6) when is_tuple(ipv6) and tuple_size(ipv6) == 8 do
    case :inet.ntoa ipv6 do
      {:error, _} -> error()
      charlist    -> ok charlist |> to_string |> to_single_colon
    end
  end

  def unmap_address _ do
    error()
  end

  defp to_double_colon string do
    Regex.replace ~r/:/, string, "::"
  end

  defp to_single_colon string do
    Regex.replace ~r/::/, string, ":"
  end
end
