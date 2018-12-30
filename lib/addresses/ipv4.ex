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
    quote bind_quoted: [type: opts[:type] || "", error: opts[:error]] do
      use MMS.Mapper.Base, error: error

      def map(string) when is_binary(string) do
        case String.split string, "/TYPE=#{unquote(type)}" do
          [address, ""]   -> do_map address
          [address, type] -> do_map {address, type}
          _               -> error()
        end
      end

      def map _ do
        error()
      end

      defp do_map arg do
        case_error apply __MODULE__, :map_address, [arg] do
          _ -> error()
        end
      end

      def unmap address  do
        do_unmap address
      end

      defp do_unmap address do
        case apply __MODULE__, :unmap_address, [address] do
          {:ok, {value, x}} -> ok value <> "/TYPE=#{x}"
          {:ok, value}      -> ok value <> "/TYPE=#{unquote(type)}"
          {:error, _}       -> error()
        end
      end
    end
  end
end

defmodule MMS.Address.IPv4 do
  use MMS.Address.Base, type: "IPv4", error: :invalid_ipv4_address
  import MMS.OkError

  def map_address string do
    string |> to_charlist |> :inet.parse_ipv4_address
  end

  def unmap_address(ipv4) when is_tuple(ipv4) and tuple_size(ipv4) == 4 do
    case :inet.ntoa ipv4 do
      {:error, _} -> error()
      charlist    -> ok to_string charlist
    end
  end

  def unmap_address _ do
    error()
  end
end
