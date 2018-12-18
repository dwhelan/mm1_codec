defmodule MMS.DataTypes do
  defmacro is_short_length value do
    is_integer value, 0, 30
  end

  defmacro is_short value do
    is_integer value, 0, 127
  end

  defmacro is_byte value do
    is_integer value, 0, 255
  end

  defmacro is_uintvar value do
    is_integer value, 0, 0xffffffff
  end

  def max_long do
    # 30 0xffs
    0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  end

  def max_long_bytes do
    <<30, max_long()::240>>
  end

  defmacro is_long_integer value do
    is_integer value, 0, max_long()
  end

  defmacro is_string value do
    quote do
      unquote(value) == 0 or unquote(value) >= 32
    end
  end

  defp is_integer value, min, max do
    quote do
      is_integer(unquote value) and unquote(value) >= unquote(min) and unquote(value) <= unquote(max)
    end
  end
end

