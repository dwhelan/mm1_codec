defmodule MMS.DataTypes do

  defp is_integer? value, min, max do
    quote do
      is_integer(unquote value) and unquote(value) >= unquote(min) and unquote(value) <= unquote(max)
    end
  end

  defmacro is_short_length value do
    is_integer? value, 1, 30
  end

  defmacro is_short value do
    is_integer? value, 0, 127
  end

  defmacro is_short_byte byte do
    is_integer? byte, 128, 255
  end

  def short(value) when is_short(value) do
    value + 128
  end

  defmacro is_byte value do
    is_integer? value, 0, 255
  end

  def max_uint32 do
    0xffffffff
  end

  def max_uint32_bytes do
    <<143, 255, 255, 255, 127>>
  end

  defmacro is_uint32 value do
    is_integer? value, 0, max_uint32()
  end

  def max_long do
    # 30 0xffs
    0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  end

  def max_long_bytes do
    <<30, max_long()::240>>
  end

  defmacro is_long value do
    is_integer? value, 0, max_long()
  end

  defmacro is_long_byte byte do
    is_integer? byte, 1, 30
  end

  defmacro is_integer value, min, max do
    is_integer? value, min, max
  end

  defmacro is_char value do
    quote do
      unquote(value) == 0 or (unquote(value) >= 32 and unquote(value) <= 127)
    end
  end
end

