defmodule OldOkError do

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

  defmacro ok_if(input, fun) do
    case fun do
      {:&, _, _} ->
        quote do
          value = unquote(input)
          case unquote(fun).(value) do
            true -> ok value
            _         -> error value
          end
        end

      _ ->
        quote do
          value = unquote(input)
          case value |> unquote(fun).() do
            true -> ok value
            _         -> error value
          end
        end
    end
  end

  def error_if(value, fun) do
    case fun.(value) do
      true -> error value
      _    -> ok value
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
    case fun do
      {:&, _, _} ->
        quote do
          case unquote(input) |> wrap do
            {:ok, value } -> unquote(fun).(value) |> wrap
            error         -> error
          end
        end

      _ ->
        quote do
          case unquote(input) |> wrap do
            {:ok, value } -> value |> unquote(fun) |> wrap
            error         -> error
          end
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
