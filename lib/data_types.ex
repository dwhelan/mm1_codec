defmodule MMS.DataTypes do

  defmacro is_byte(value),          do: value |> in_range?(0..255)
  defmacro is_short_integer(value), do: value |> in_range?(0..127)
  defmacro is_short_byte(byte),     do: byte |> in_range?(128..255)
  defmacro is_char(value),          do: value |> in_range?(32..127)
  defmacro is_short_length(value),  do: value |> in_range?(0..max_short_length())
  defmacro is_uint32(value),        do: value |> in_range?(0..max_uint32())
  defmacro is_long(value),          do: value |> in_range?(0..max_long())

  defmacro is_end_of_string(value) do
    quote do unquote(value) == 0 end
  end

  defmacro is_quote(value) do
    quote do unquote(value) == 34 end
  end

  defmacro is_text(value) do
    quote do is_end_of_string(unquote value) or is_char(unquote value) end
  end

  defmacro is_2_digit_q_value(value), do: value |> in_range?(1..100)
  defmacro is_3_digit_q_value(value), do: value |> in_range?(101..1099)

  def no_value_byte, do: 0
  def no_value,      do: :no_value

  defmacro is_no_value_byte(byte) do
    quote do
      unquote(byte) == 0
    end
  end

  defmacro is_no_value(value) do
    quote do
      unquote(value) == :no_value
    end
  end
  def max_short_length, do: 30
  def max_uint32,       do: 0xffffffff
  def max_uint32_bytes, do: <<143, 255, 255, 255, 127>>
  def max_long,         do: 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff # 30 0xffs
  def max_long_bytes,   do: <<max_short_length(), max_long()::240>>

  defp in_range? value, range do
    quote do unquote(value) in unquote(Macro.escape range) end
  end
end
