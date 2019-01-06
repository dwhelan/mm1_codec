defmodule OkError.Module do

  defmacro atom module do
    build_atom module
  end

  defmacro atom do
    build_atom __CALLER__.module
  end

  defp build_atom module do
    quote do
      unquote(module) |> to_string |> String.split(".") |> List.last |> Macro.underscore |> String.to_atom
    end
  end

  defmacro error_atom module do
    build_error_atom module
  end

  defmacro error_atom do
    build_error_atom __CALLER__.module
  end

  defp build_error_atom module do
    atom = build_atom module

    quote do
      "invalid_#{unquote atom}" |> String.replace(~r/(_[a-z)])_/, "\\1") |> String.to_atom
    end
  end
end
