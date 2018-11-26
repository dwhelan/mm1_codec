defmodule MM1.Result do
  defstruct value: nil, bytes: <<>>, rest: <<>>, module: nil, err: nil

  defmacro ok value, bytes, rest \\ <<>> do
    result module(__CALLER__), value, bytes, rest
  end

  defmacro err value, error, bytes \\ <<>>, rest \\ <<>> do
    result module(__CALLER__), value, bytes, rest, error
  end

  defp module caller do
    caller.context_modules |> List.first
  end

  defp result module, value, bytes, rest, error \\ nil do
    quote do
      %MM1.Result{value: unquote(value), module: unquote(module), bytes: unquote(bytes), rest: unquote(rest), err: unquote(error)}
    end
  end
end

