defmodule OkError do

  defmacro cons _value, block do
    quote do
      unquote(block)
    end
  end

  def tuple(value, tuple) when is_tuple(tuple), do: Tuple.insert_at(tuple, 0, value)
  def tuple(value, other),                      do: {value, other}

  def ok value, rest do
    {:ok, {value, rest}}
  end

  def ok value do
    {:ok, value}
  end

  def error module, reason do
    {:error, {module, reason}}
  end

  def error reason do
    {:error, reason}
  end

  defmacro caller do
    __CALLER__.context_modules |> hd
  end

  defmacro caller(caller) do
    caller.context_modules |> hd
  end

  defmacro error do
    __CALLER__ |> caller_error
  end

  defmacro module_error _reason \\ nil do
    __CALLER__ |> caller_error
  end

  defp caller_error caller do
    caller.context_modules |> hd |> error_reason |> error
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

  defmacro case_ok value, do: block do
    quote do
      case unquote value do
        {:error, _} = error -> error
        nil                 -> nil
        {:ok, value}        -> case value, do: unquote(block)
        value               -> case value, do: unquote(block)
      end
    end
  end

  defmacro case_error value, do: block do
    quote do
      case unquote value do
        {:error, reason} -> case reason, do: unquote(block)
        nil              -> case nil,    do: unquote(block)
        ok               -> ok
      end
    end
  end

  # if_ok seems like a good idea but is not being used ... delete ???
  defmacro is_ok value do
    quote do
      case unquote value do
        {:error, _} -> false
        nil         -> false
        _           -> true
      end
    end
  end

  defmacro is_error value do
    quote do
      ! is_ok(unquote value)
    end
  end

  defmacro if_ok value, clauses do
    build_if_ok value, clauses
  end

  defp build_if_ok value, do: do_clause do
    build_if_ok value, do: do_clause, else: nil
  end

  defp build_if_ok value, do: do_clause, else: else_clause do
    quote do
      if (is_ok unquote(value)), do: unquote(do_clause), else: unquote(else_clause)
    end
  end

  defp build_if_ok _condition, _arguments do
    raise ArgumentError,
          "invalid or duplicate keys for if_ok, " <>
          "only \"do\" and an optional \"else\" are permitted"
  end

  # if_error seems like a good idea but is not being used ... delete ???
  defmacro if_error value, clauses do
    build_if_error value, clauses
  end

  defp build_if_error value, do: do_clause do
    build_if_error value, do: do_clause, else: nil
  end

  defp build_if_error value, do: do_clause, else: else_clause do
    quote do
      if (is_error unquote(value)), do: unquote(do_clause), else: unquote(else_clause)
    end
  end

  defp build_if_error _condition, _arguments do
    raise ArgumentError,
          "invalid or duplicate keys for if_error, " <>
          "only \"do\" and an optional \"else\" are permitted"
  end

  def first_ok(args, fun) do
    Enum.reduce_while(args, nil, fn arg, _ ->
      if_ok acc = fun.(arg) do
        {:halt, acc}
      else
        {:cont, acc}
      end
    end)
  end
end
