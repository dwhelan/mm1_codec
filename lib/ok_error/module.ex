defmodule OkError.Module do

  defmacro atom module \\ __CALLER__.module do
    quote do
      unquote(module) |> to_string |> String.split(".") |> List.last |> Macro.underscore |> String.to_atom
    end
  end

  defmacro error_atom module \\ __CALLER__.module do
    quote do
      "invalid_#{OkError.Module.atom unquote(module)}" |> String.replace(~r/(_[a-z)])_/, "\\1") |> String.to_atom
    end
  end
end
