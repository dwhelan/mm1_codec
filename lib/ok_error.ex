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
    "invalid_#{name}" |> combine_single_letters |> String.to_atom
  end

  defp combine_single_letters string do
    String.replace string, ~r/(_[a-z)])_/, "\\1"
  end

  def wrap2 value do
    case value do
      {:ok, value}     -> {:ok, value}
      {:error, reason} -> {:error, reason}
      value            -> {:ok, value}
    end
  end

  defmacro input ~> fun do
    quote do
      case unquote(input) do
        {:error, reason} -> error reason
        {:ok, value}     -> value |> unquote(fun) |> wrap2
        value            -> value |> unquote(fun) |> wrap2
      end

    end
  end

  defmacro input ~>> fun do
    quote do
      case unquote(input) do
        {:error, reason} -> reason |> unquote(fun) |> error
        {:ok, value}     -> {:ok, value}
        value            -> {:ok, value}
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
