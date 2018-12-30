defmodule MMS.Address.IPv6 do
  use MMS.Address.Base, type: "IPv6", error: :invalid_ipv6_address
  import MMS.OkError

  def map_address string do
    string |> double_colon |> to_charlist |> :inet.parse_ipv6_address
  end

  def unmap_address(ipv6) when is_tuple(ipv6) and tuple_size(ipv6) == 8 do
    case :inet.ntoa ipv6 do
      {:error, _} -> error()
      charlist    -> ok charlist |> to_string |> single_colon
    end
  end

  def unmap_address _ do
    error()
  end

  #  def map string do
#    case string |> double_colon |> to_charlist |> :inet.parse_ipv6_address do
#      {:ok, ipv6} -> ok ipv6
#      _           -> error :invalid_ipv6_address
#    end
#  end
#
#  def unmap(ipv6) when is_tuple(ipv6) and tuple_size(ipv6) == 8  do
#    ok (ipv6 |> :inet.ntoa |> to_string |> single_colon) <> "/TYPE=IPv6"
#  end
#
#  def unmap _ do
#    error :invalid_ipv6_address
#  end
#
#  def is_ipv6? value do
#    is_tuple(value) and tuple_size(value) == 8
#  end

  defp double_colon string do
    Regex.replace ~r/:/, string, "::"
  end

  defp single_colon string do
    Regex.replace ~r/::/, string, ":"
  end
end
