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
      {:ok, _}    -> value
      {:error, _} -> value
      nil         -> error nil
      _           -> ok value
    end
  end

  def wrap_as_error value do
    case value do
      {:ok, _}    -> value
      {:error, _} -> value
      _           -> error value
    end
  end
  
  defmacro module_error _reason \\ nil do
    __CALLER__.module |> error_reason |> error
  end

  def error_reason module do
    name = module |> to_string |> String.split(".") |> List.last |> Macro.underscore
    "invalid_#{name}" |> String.replace(~r/(_[a-z)])_/, "\\1") |> String.to_atom
  end

  defmacro input ~> fun do
    quote do
      case wrap unquote(input) do
        {:ok, value } -> value |> unquote(fun) |> wrap
        error         -> error
      end

    end
  end

  defmacro input ~>> fun do
    quote do
      case wrap unquote(input) do
        {:error, reason} -> reason |> unquote(fun) |> wrap_as_error
        ok               -> ok
      end
    end
  end
end
