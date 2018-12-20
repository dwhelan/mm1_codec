defmodule MMS.Address.IPv6 do
  import MMS.OkError

  def map string do
    case string |> double_colon |> to_charlist |> :inet.parse_ipv6_address do
      {:ok, ipv6} -> ok ipv6
      _           -> error :invalid_ipv6_address
    end
  end

  def unmap ipv6 do
    (ipv6 |> :inet.ntoa |> to_string |> single_colon) <> "/TYPE=IPv6"
  end

  def is_ipv6? value do
    is_tuple(value) and tuple_size(value) == 8
  end

  defp double_colon string do
    Regex.replace ~r/:/, string, "::"
  end

  defp single_colon string do
    Regex.replace ~r/::/, string, ":"
  end
end
