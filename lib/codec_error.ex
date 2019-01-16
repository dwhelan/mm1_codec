defmodule CodecError do
  require OldOkError.String

  defmacro name module \\ __CALLER__.module do
    quote do
      unquote(module)
      |> to_string
      |> String.split(".")
      |> List.last
      |> OldOkError.String.pascalcase
      |> Macro.underscore
      |> String.to_atom
    end
  end

  defmacro error_name module \\ __CALLER__.module do
    quote do
      "invalid_#{CodecError.name unquote(module)}" |> String.to_atom
    end
  end

  defmacro module_error _reason \\ nil do
    __CALLER__.module |> error_reason |> OldOkError.error
  end


  def error_reason module do
    name = module |> to_string |> String.split(".") |> List.last |> Macro.underscore
    "invalid_#{name}" |> String.replace(~r/(_[a-z)])_/, "\\1") |> String.to_atom
  end

end
