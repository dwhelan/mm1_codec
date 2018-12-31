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

  def error_reason module do
    name = module |> to_string |> String.split(".") |> List.last |> Macro.underscore
    "invalid_#{name}" |> preserve_acronyms |> String.to_atom
  end

  defp preserve_acronyms string do
    String.replace string, ~r/(_[a-z)])_/, "\\1"
  end

  def wrap(tuple) when is_tuple(tuple), do: tuple
  def wrap(value),                      do: {:ok, value}

  def wrap_as_error(tuple) when is_tuple(tuple), do: tuple
  def wrap_as_error(value),                      do: {:error, value}

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
