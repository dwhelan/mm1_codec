defmodule OldOkError.Operators do
  import OldOkError

  defmacro input ~> fun do
    quote do
      when_ok unquote(input), unquote(fun)
    end
  end

  defmacro input ~>> fun do
    quote do
      when_error unquote(input), unquote(fun)
    end
  end
end
