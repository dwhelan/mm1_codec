defmodule MMS.Codec do
  import OkError

  def prepend(string, prefix), do: prefix <> string
  def append( string, suffix), do: string <> suffix

  def remove_trailing(string, count), do: string |> String.slice(0..-count-1)

  defmacro input <~> fun do
    quote do
      case unquote(input) |> wrap do
        {:ok, {value, rest}} -> value |> unquote(fun) ~> ok(rest) # for decode
        {:ok, value}         -> value |> unquote(fun)             # for encode
        error                -> error
      end ~>> module_error()
    end
  end

  defmacro defcodec opts \\ [] do
    quote bind_quoted: [opts: opts] do
      cond do
        opts[:either] -> use MMS.OneOf, codecs: opts[:either]
        true -> IO.inspect  "nuthing"
      end
    end
  end
  defmacro defaults do
    quote do
      def decode(_), do: error()
      def encode(_), do: error()
    end
  end

  defmacro __using__(_) do
    quote do
      import OkError
      import MMS.{DataTypes, Codec}

      def decode(nil),  do: error()
      def decode(<<>>), do: error()
      def decode(value) when not is_binary(value), do: error()
    end
  end
end
