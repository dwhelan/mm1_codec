defmodule MMS.DataTypes do

  defmacro is_byte(value),          do: value |> in_range?(0..255)
  defmacro is_short(value),         do: value |> in_range?(0..127)
  defmacro is_short_length(value),  do: value |> in_range?(0..max_short_length())
  defmacro is_uint32(value),        do: value |> in_range?(0..max_uint32())
  defmacro is_long(value),          do: value |> in_range?(0..max_long())

  defmacro is_char(byte) do
    quote do unquote(byte) == 0 or (unquote(byte) in 32..127) end
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

