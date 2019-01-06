defmodule OkError.Module do

  defmacro atom do
    atom __CALLER__.module
  end

  def atom module do
    module |> to_string |> String.split(".") |> List.last |> Macro.underscore |> preserve_acronyms |> String.to_atom
  end

  defp preserve_acronyms string do
    string |> String.replace(~r/(_[a-z)])_/, "\\1")
  end

end
