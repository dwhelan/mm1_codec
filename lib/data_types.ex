defmodule MMS.DataTypes do

  @chars      0..127 |> Enum.into([])
  @controls   0..31  |> Enum.into([127])
  @separators ~c|()<>@,;:\\"/[]?={}\s\t|
  @tokens     @chars -- @controls ++ @separators

  defmacro is_byte(value),              do: value |> in?(0..255)
  defmacro is_short_integer(value),     do: value |> in?(0..127)
  defmacro is_short_integer_byte(byte), do: byte  |> in?(128..255)
  defmacro is_char(value),              do: value |> in?(32..127)
  defmacro is_short_length(value),      do: value |> in?(0..max_short_length())
  defmacro is_uint32(value),            do: value |> in?(0..max_uint32())
  defmacro is_long(value),              do: value |> in?(0..max_long())
  defmacro is_end_of_string(value),     do: value |> is_equal_to?(end_of_string())
  defmacro is_length_quote(value),      do: value |> is_equal_to?(length_quote())
  defmacro is_quote(value),             do: value |> is_equal_to?(quote())
  defmacro is_no_value_byte(byte),      do: byte  |> is_equal_to?(no_value_byte())
  defmacro is_no_value(value),          do: value |> is_equal_to?(no_value())
  defmacro is_2_digit_q_value(value),   do: value |> in?(1..100)
  defmacro is_3_digit_q_value(value),   do: value |> in?(101..1099)
  defmacro is_separator(value),         do: value |> in?(@separators)
  defmacro is_control(value),           do: value |> in?(@controls)
  defmacro is_token(value),             do: value |> in?(@tokens)

  defmacro is_text(value) do
    quote do is_char(unquote value) or is_end_of_string(unquote value) end
  end

  defmacro is_address(value) do
    quote do is_tuple(unquote value) and tuple_size(unquote value) == 2 and is_binary(elem unquote(value), 0) and is_binary(elem unquote(value), 1) end
  end

  def max_short_length, do: 30
  def max_uint32,       do: 0xffffffff
  def max_uint32_bytes, do: <<143, 255, 255, 255, 127>>
  def max_long,         do: 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff # 30 0xffs
  def max_long_bytes,   do: <<max_short_length(), max_long()::240>>
  def end_of_string,    do: 0
  def quote,            do: 34
  def length_quote,     do: 31
  def no_value_byte,    do: 0
  def no_value,         do: :no_value

  defp in? value, range do
    quote do unquote(value) in unquote(Macro.escape range) end
  end

  defp is_equal_to? value, expected do
    quote do unquote(value) == unquote(expected) end
  end
end
