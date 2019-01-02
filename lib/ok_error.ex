defmodule MMS.OkError do

  def ok value, rest do
    {:ok, {value, rest}}
  end

  def ok value do
    {:ok, value}
  end

  def error codec, reason do
    {:error, {codec, reason}}
  end

  def error {:error, reason} do
    {:error, reason}
  end

  def error reason do
    {:error, reason}
  end

  defmacro either(input, fun) do
    quote do
      unquote(input) ~> unquote(fun)
    end
  end

  def error_reason module do
    name = module |> to_string |> String.split(".") |> List.last |> Macro.underscore
    "invalid_#{name}" |> preserve_acronyms |> String.to_atom
  end

  defp preserve_acronyms string do
    String.replace string, ~r/(_[a-z)])_/, "\\1"
  end

  defmacro error do
    {:error, __CALLER__.context_modules |> hd |> error_reason}
  end

  defmacro module_error _reason do
    {:error, __CALLER__.context_modules |> hd |> error_reason}
  end

  def wrap(value) when is_tuple(value),        do: value
  def wrap(value),                             do: ok value
#  def wrap(value, tuple) when is_tuple(value), do: value
#  def wrap(value, tuple),                      do: {:ok, :erlang.setelement(1, tuple, value)}

  def wrap_as_error(tuple) when is_tuple(tuple), do: tuple
  def wrap_as_error(value),                      do: {:error, value}

  defmacro input ~> fun do
    quote do
      case wrap unquote(input) do
#        {:ok, tuple } when is_tuple(tuple) -> elem(tuple, 0) |> unquote(fun) |> wrap(tuple)
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

  defmacro case_ok value, do: block do
    quote do
      case unquote value do
        {:error, _} = error -> error
        {:ok, value}        -> case value, do: unquote(block)
        value               -> case value, do: unquote(block)
      end
    end
  end

  defmacro case_error value, do: block do
    quote do
      case unquote value do
        {:error , reason} -> case reason, do: unquote(block)
        ok                -> ok
      end
    end
  end
end
