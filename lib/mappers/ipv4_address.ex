defmodule MMS.Mapper.Base do
  defmacro __using__ opts \\ [] do
    quote do
      import MMS.OkError

      @reason error_reason __MODULE__

      def error do
        error @reason
      end
    end
  end
end

defmodule MMS.Address.Base do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [type: opts[:type]] do
      use MMS.Mapper.Base

      def map(string) when is_binary(string) do
        case String.split string, "/TYPE=#{unquote(type)}" do
          [address, ""  ] -> do_map address
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
          {:ok, {value, type}} -> ok value <> "/TYPE=#{type}"
          {:ok, value}         -> ok value <> "/TYPE=#{unquote(type)}"
          {:error, _}          -> error()
          value                -> ok value <> "/TYPE=#{unquote(type)}"
        end
      end
    end
  end
end

defmodule MMS.Mapper.IPv4Address do
  use MMS.Address.Base, type: "IPv4"

  def map_address string do
    string |> to_charlist |> :inet.parse_ipv4strict_address
  end

  def unmap_address(ipv4) when is_tuple(ipv4) and tuple_size(ipv4) == 4 do
    case_ok :inet.ntoa ipv4 do
      charlist -> to_string charlist
    end
  end

  def unmap_address _ do
    error()
  end
end
