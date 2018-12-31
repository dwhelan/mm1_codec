defmodule MMS.Mapper.Base do
  defmacro __using__ _opts do
    quote do
      import MMS.OkError
      import MMS.Mapper.Base

      @reason error_reason __MODULE__

      def error do
        error @reason
      end

      def module_error _reason do
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
        string |> split ~> _map_address
      end

      defp split string do
        case String.split string, "/TYPE=#{unquote(type)}" do
          [address, ""  ] -> ok address
          [address, type] -> ok {address, type}
          _               -> error()
        end
      end

      def map _ do
        error()
      end

      defp _map_address arg do
        apply(__MODULE__, :map_address, [arg]) ~>> module_error
      end

      def unmap address  do
        case apply __MODULE__, :unmap_address, [address] do
          {:ok, {value, type}} -> ok value <> "/TYPE=#{type}"
          {:ok, value}         -> ok value <> "/TYPE=#{unquote(type)}"
          {:error, _}          -> error()
          :error               -> error()
          value                -> ok value <> "/TYPE=#{unquote(type)}"
        end
      end

      defp do_unmap address do
        apply __MODULE__, :unmap_address, [address]
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
    ipv4 |> :inet.ntoa ~> to_string
  end

  def unmap_address _ do
   :error
  end
end
