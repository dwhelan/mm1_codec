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

  defmacro module_error _reason \\ nil do
    __CALLER__.module |> error_reason |> error
  end

  def error_reason module do
    name = module |> to_string |> String.split(".") |> List.last |> Macro.underscore
    "invalid_#{name}" |> preserve_acronyms |> String.to_atom
  end

  defp preserve_acronyms string do
    string |> String.replace(~r/(_[a-z)])_/, "\\1")
  end

  def wrap(tuple = {:ok,    _}), do: tuple
  def wrap(tuple = {:error, _}), do: tuple
  def wrap(nil)  ,               do: error nil
  def wrap(value),               do: ok value

  def wrap_as_error(tuple = {:ok,    _}), do: tuple
  def wrap_as_error(tuple = {:error, _}), do: tuple
  def wrap_as_error(value),               do: error value

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
