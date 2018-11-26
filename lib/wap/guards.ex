defmodule WAP.Guards do

  defp is_unsigned_integer value, max do
    quote do
      is_integer(unquote value) and unquote(value) >= 0 and unquote(value) <= unquote(max)
    end
  end

  defmacro is_short_length value do
    is_unsigned_integer value, 30
  end

  defmacro is_short_integer value do
    is_unsigned_integer value, 127
  end

  defmacro is_byte value do
    is_unsigned_integer value, 255
  end

  defmacro is_uintvar value do
    is_unsigned_integer value, 0xffffffff
  end
end

