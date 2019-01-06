defmodule MMS.Codec do
  import OkError

  def prepend(string, prefix), do: prefix <> string
  def append( string, suffix), do: string <> suffix

  def remove_trailing(string, count), do: string |> String.slice(0..-count-1)

  defmacro codec_error input do
    quote do
      case unquote(input) |> wrap do
        {:error, reason} -> error(:foo, [reason])
        ok               -> ok
      end
    end
  end

  defmacro input <~> fun do
    quote do
      case unquote(input) |> wrap do
        {:ok, {value, rest}} -> value |> unquote(fun) ~> ok(rest) # for decode
        {:ok, value}         -> value |> unquote(fun)             # for encode
        error                -> error
      end ~>> module_error()
    end
  end

  defmacro input <|> fun do
    quote do
      case unquote(input) |> wrap do
        {:ok, {value, rest}} -> value |> unquote(fun) ~> ok(rest) # for decode
        {:ok, value}         -> value |> unquote(fun)             # for encode
        error                -> error
      end
    end
  end

  defmacro defaults do
    quote do
      def decode(_), do: error()
      def encode(_), do: error()
    end
  end

  defmacro __using__([]) do
    quote do
      import OkError
      import MMS.{DataTypes, Codec}

      def decode(nil),  do: error()
      def decode(<<>>), do: error()
      def decode(value) when not is_binary(value), do: error()
    end
  end

  defmacro __using__(_opts) do
    raise ArgumentError, "'use MMS.Codec' does not accept any options"
  end
end
