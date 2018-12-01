defmodule MM1.Result do
  defstruct module: nil, value: nil, bytes: <<>>, rest: <<>>, err: nil

  alias MM1.Result

  defmacro decode_ok value, bytes, rest do
    module = module __CALLER__
    quote do
      %Result{module: unquote(module), value: unquote(value), bytes: unquote(bytes), rest: unquote(rest)}
    end
  end

  defmacro decode_error error, value, bytes, rest do
    module = module __CALLER__
    quote do
      %Result{module: unquote(module), err: unquote(error), value: unquote(value), bytes: unquote(bytes), rest: unquote(rest)}
    end
  end

  defmacro new_ok value, bytes do
    module = module __CALLER__
    quote do
      %Result{module: unquote(module), value: unquote(value), bytes: unquote(bytes)}
    end
  end

  defmacro new_error error, value do
    module = module __CALLER__
    quote do
      %Result{module: unquote(module), err: unquote(error), value: unquote(value)}
    end
  end

  defmacro embed result, module \\ module __CALLER__ do
    quote do
      %Result{unquote(result) | module: unquote(module)}
    end
  end

  defp module caller do
    caller.context_modules |> List.first
  end
end
