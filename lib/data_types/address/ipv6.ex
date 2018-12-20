defmodule MMS.Address.IPv6 do
  import MMS.OkError

  def map string do
    case string |> double_colon |> to_charlist |> :inet.parse_ipv6_address do
      {:ok, ipv6} -> ok ipv6
      _           -> error :invalid_ipv6_address
    end
  end

  def unmap value do
    (value |> :inet.ntoa |> to_string |> single_colon) <> "/TYPE=IPv6"
  end

  defp double_colon string do
    Regex.replace ~r/:/, string, "::"
  end

  defp single_colon string do
    Regex.replace ~r/::/, string, ":"
  end
end
