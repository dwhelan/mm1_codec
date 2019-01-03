defmodule MMS.Codec do
  def prepend string, prefix do
    prefix <> string
  end

  def append string, suffix do
    string <> suffix
  end

  def remove_trailing string, count do
    String.slice string, 0..-(count+1)
  end

  defmacro map_value input, fun do
    do_map_value input, fun
  end

  defmacro input <~> fun do
    do_map_value input, fun
  end

  defp do_map_value input, fun do
    quote do
      case wrap unquote(input) do
        {:ok, {value, rest}} -> value |> unquote(fun) ~> ok(rest) ~>> module_error()
        {:ok, value}         -> value |> unquote(fun) ~> ok       ~>> module_error()
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
