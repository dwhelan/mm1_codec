defmodule OkError.Module do

  defmacro atom module do
    quote do
      unquote(module) |> to_string |> String.split(".") |> List.last |> Macro.underscore |> OkError.Module.preserve_acronyms |> String.to_atom
    end
  end

  defmacro atom do
    atom __CALLER__.module
  end

  def preserve_acronyms string do
    string |> String.replace(~r/(_[a-z)])_/, "\\1")
  end
end
