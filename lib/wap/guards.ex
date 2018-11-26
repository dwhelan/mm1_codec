defmodule WAP.Guards do
  defmacro is_integer(value, min, max) do
    quote do
      is_integer(unquote(value)) and unquote(value) >= unquote(min) and unquote(value) <= unquote(max)
    end
  end

  defmacro is_short_length(value) do
    quote do
      is_integer(unquote(value), 0, 30)
    end
  end

  defmacro is_short_integer(value) do
    quote do
      is_integer(unquote(value), 0, 127)
    end
  end

  defmacro is_uintvar(value) do
    quote do
      is_integer(unquote(value), 0, 0xffffffff)
    end
  end

  defmacro decode_error error, value, bytes, rest do
    [module | _] = __CALLER__.context_modules
    quote do
      %MM1.Result{err: unquote(error), value: unquote(value), module: unquote(module), bytes: unquote(bytes), rest: unquote(rest)}
    end
  end

  defmacro new_error error, value do
    [module | _] = __CALLER__.context_modules
    quote do
      %MM1.Result{err: unquote(error), value: unquote(value), module: unquote(module)}
    end
  end

end

