defmodule CodecError do
  import OkError

  def name module do
    module
    |> to_string
    |> String.split(".")
    |> List.last
    |> Codec.String.pascalcase
    |> Macro.underscore
    |> String.to_atom
  end

  defmacro data_type module \\ __CALLER__.module do
    quote do
      name unquote(module)
    end
  end

  defmacro module_error _reason \\ nil do
    __CALLER__.module |> data_type |> error
  end
end
