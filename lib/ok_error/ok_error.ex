defmodule OkError do

  defmacro cons _value, block do
    quote do
      unquote(block)
    end
  end
  
  def ok value, other do
    {:ok, {value, other}}
  end

  def ok value do
    {:ok, value}
  end

  def error reason, other do
    {:error, {reason, other}}
  end

  def error reason do
    {:error, reason}
  end

  def wrap value do
    case value do
      {:ok,    _} -> value
      {:error, _} -> value
      nil         -> error nil
      _           -> ok value
    end
  end

  def wrap_as_error value do
    case value do
      {:ok,    _} -> value
      {:error, _} -> value
      _           -> error value
    end
  end

  defmacro when_ok input, fun do
    quote do
      case unquote(input) |> wrap do
        {:ok, value } -> value |> unquote(fun) |> wrap
        error         -> error
      end
    end
  end

  defmacro when_error input, fun do
    quote do
      case unquote(input) |> wrap do
        {:error, reason} -> reason |> unquote(fun) |> wrap_as_error
        ok               -> ok
      end
    end
  end
end
