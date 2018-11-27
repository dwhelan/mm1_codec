defmodule MM1.Result do
  defstruct module: nil, value: nil, bytes: <<>>, rest: <<>>, err: nil

  defmacro ok value, bytes, rest \\ <<>> do
    result module(__CALLER__), value, bytes, rest
  end

  defmacro error2 value, error, bytes \\ <<>>, rest \\ <<>> do
    result module(__CALLER__), value, bytes, rest, error
  end

  defp module caller do
    caller.context_modules |> List.first
  end

  defp result module, value, bytes, rest, error \\ nil do
    quote do
      %MM1.Result{module: unquote(module), value: unquote(value), bytes: unquote(bytes), rest: unquote(rest), err: unquote(error)}
    end
  end
end

