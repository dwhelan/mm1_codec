defmodule MM1.Result do
  defstruct value: nil, bytes: <<>>, rest: <<>>, module: nil, err: nil

  defmacro decode_ok value, bytes, rest \\ <<>> do
    result module(__CALLER__), value, bytes, rest
  end

  defmacro decode_error value, bytes, rest, error do
    result module(__CALLER__), value, bytes, rest, error
  end

  defmacro new_ok value, bytes do
    result module(__CALLER__), value, bytes, <<>>
  end

  defmacro new_error value, error do
    result module(__CALLER__), value, <<>>, <<>>, error
  end

  defp module caller do
    caller.context_modules |> List.first
  end

  defp result(module, value, bytes, rest, error \\ nil) do
    quote do
      %MM1.Result{value: unquote(value), module: unquote(module), bytes: unquote(bytes), rest: unquote(rest), err: unquote(error)}
    end
  end
end

