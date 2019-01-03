defmodule MMS.Codec do
  def prefix(bytes, prefix) when is_integer(prefix) do
    <<prefix>> <> bytes
  end

  defmacro map_value input, fun do
    quote do
      case wrap unquote(input) do
      {:ok, {value, rest}} -> value |> unquote(fun) ~> ok(rest) ~>> module_error()
        error                -> module_error()
      end
    end
  end

  defmacro defaults do
    import MMS.OkError

    quote do
      def decode _ do
        error()
      end

      def encode _ do
        error()
      end
    end
  end

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import MMS.OkError
      import MMS.DataTypes
      import MMS.Codec

      def decode(value) when is_binary(value) == false do
        error()
      end

      def decode <<>> do
        error()
      end

      def decode nil do
        error()
      end

      import MMS.Codec
    end
  end
end
