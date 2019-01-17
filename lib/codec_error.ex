defmodule CodecError do
  import OkError

  defmacro error_name module \\ __CALLER__.module do
    quote do
      "invalid_#{Codec.name unquote(module)}" |> String.to_atom
    end
  end

  defmacro module_error _reason \\ nil do
    __CALLER__.module |> error_name |> error
  end

  defmacro encode_error _reason \\ nil do
    __CALLER__.module |> error_name |> error
  end
end
