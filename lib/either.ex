defmodule MMS.Either do
  defmacro __using__ types \\ [] do
    check_types types

    quote do
      import OkError

      def decode bytes do
        first_ok unquote(types), & &1.decode(bytes) ~>> module_error()
      end

      def encode value do
        first_ok unquote(types), & &1.encode(value) ~>> module_error()
      end
    end
  end

  defp check_types types do
    if Keyword.keyword?(types) do
      raise ArgumentError, """
        "use MMS.Either" expects to be passed a list of codecs. For example:


          defmodule MyCodec do
            use MMS.Either, [MMS.Byte. MMS.Short]
          end
        """
    end
  end
end
