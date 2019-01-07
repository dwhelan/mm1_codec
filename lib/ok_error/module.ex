defmodule OkError.Module do
  require OkError.String

  defmacro name module \\ __CALLER__.module do
    quote do
      unquote(module)
      |> to_string
      |> String.split(".")
      |> List.last
      |> OkError.String.pascalcase
      |> Macro.underscore
      |> String.to_atom
    end
  end

  defmacro error_name module \\ __CALLER__.module do
    quote do
      "invalid_#{OkError.Module.name unquote(module)}" |> String.to_atom
    end
  end
end
