defmodule MMS.Address.Base do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [type: opts[:type]] do
      import OldOkError
      import OldOkError.{Operators}
      import CodecError

      def map(string) when is_binary(string) do
        string |> split ~> do_map
      end

      defp split string do
        case String.split string, "/TYPE=#{unquote(type)}" do
          [address, ""  ] -> ok address
          [address, type] -> ok {address, type}
          _               -> module_error()
        end
      end

      def map _ do
        module_error()
      end

      defp do_map arg do
        apply(__MODULE__, :map_address, [arg]) ~>> module_error
      end

      def unmap address  do
        case do_unmap address do
          {:ok, {value, type}} -> ok value <> "/TYPE=#{type}"
          {:ok, value}         -> ok value <> "/TYPE=#{unquote(type)}"
          {:error, _}          -> module_error()
#          :error               -> module_error()
          value                -> ok value <> "/TYPE=#{unquote(type)}"
        end
      end

      defp do_unmap address do
        apply __MODULE__, :unmap_address, [address]
      end
    end
  end
end
