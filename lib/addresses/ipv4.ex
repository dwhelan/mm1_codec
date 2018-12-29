defmodule MMS.Mapper.Base do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      def error() do

      end
    end
  end
end

defmodule MMS.Address.IPv4 do
  import MMS.OkError

  def map string do
    case String.split string, "/TYPE=IPv4", parts: 2 do
      [ipv4_string, ""] -> parse ipv4_string
      _                 -> error :invalid_ipv4_address
    end
  end

  def parse string do
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
end
