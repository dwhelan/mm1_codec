defmodule CodecError do
  require Codec.String
  import OkError

#  defmacro name module \\ __CALLER__.module do
#    quote do
#      unquote(module)
#      |> to_string
#      |> String.split(".")
#      |> List.last
#      |> Codec.String.pascalcase
#      |> Macro.underscore
#      |> String.to_atom
#    end
#  end
#
  defmacro error_name module \\ __CALLER__.module do
    quote do
      "invalid_#{Codec.name unquote(module)}" |> String.to_atom
    end
  end

  defmacro module_error _reason \\ nil do
    __CALLER__.module |> error_name |> error
  end

  defmacro encode_error _reason \\ nil do
    __CALLER__.module |> error_reason |> error
  end

  def error_reason module do
    name = module |> to_string |> String.split(".") |> List.last |> Macro.underscore
    "invalid_#{name}" |> String.replace(~r/(_[a-z)])_/, "\\1") |> String.to_atom
  end
end
