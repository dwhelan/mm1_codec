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

defmodule MMS.Address.Base do
  import MMS.OkError

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [type: opts[:type], error: opts[:error]] do
      use MMS.Mapper.Base, error: error

      def map(string) when is_binary(string) do
        case String.split string, "/TYPE=#{unquote(type)}", parts: 2 do
          [address, ""] -> do_map address
          _             -> {:error, :foox}
        end
      end

      def map _ do
        error()
      end

      defp do_map address do
        case_error apply __MODULE__, :map_address, [address] do
          _ -> error()
        end
      end
    end
  end
end

defmodule MMS.Address.IPv4 do
  use MMS.Address.Base, type: "IPv4", error: :invalid_ipv4_address
  import MMS.OkError

  def map_address address do
    address |> to_charlist |> :inet.parse_ipv4_address
  end

  def unmap(ipv4) when is_tuple(ipv4) and tuple_size(ipv4) == 4  do
    ok (ipv4 |> :inet.ntoa |> to_string) <> "/TYPE=IPv4"
  end

  def unmap _ do
    {:error, :foo2}
  end
end
