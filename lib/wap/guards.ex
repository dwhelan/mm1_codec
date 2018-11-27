defmodule WAP.Guards do

  defp is_unsigned_integer value, min, max do
    quote do
      is_integer(unquote value) and unquote(value) >= unquote(min) and unquote(value) <= unquote(max)
    end
  end

  defmacro is_short_length value do
    is_unsigned_integer value, 0, 30
  end

  defmacro is_short_integer value do
    is_unsigned_integer value, 0, 127
  end

  defmacro is_short_integer_byte byte do
    is_unsigned_integer byte, 128, 255
  end

  defmacro is_byte value do
    is_unsigned_integer value, 0, 255
  end

  defmacro is_uintvar value do
    is_unsigned_integer value, 0, 0xffffffff
  end

  defmacro is_long_integer value do
    is_unsigned_integer value, 0, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  end
end

