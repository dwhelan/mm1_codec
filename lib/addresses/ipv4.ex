defmodule MMS.Mapper.Base do
  import MMS.OkError

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      @reason opts[:error] || error_reason __MODULE__

      def error do
        error @reason
      end
    end
  end
end

defmodule MMS.Address.IPv4 do
  use MMS.Mapper.Base, error: :invalid_ipv4_address
  import MMS.OkError

  def address_from string, type, cb do
    case String.split string, "/TYPE=#{type}", parts: 2 do
      [address, ""] -> cb.(address)
      _             -> error()
    end
  end

  def map string do
    address_from string, "IPv4", fn ipv4_string ->
      case ipv4_string |> to_charlist |> :inet.parse_ipv4_address do
        {:ok, ipv4} -> ok ipv4
        _           -> error()
      end
    end
  end

  def unmap(ipv4) when is_tuple(ipv4) and tuple_size(ipv4) == 4  do
    ok (ipv4 |> :inet.ntoa |> to_string) <> "/TYPE=IPv4"
  end

  def unmap _ do
    error()
  end
end
