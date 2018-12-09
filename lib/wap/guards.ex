defmodule WAP.Guards do
  # Should be in MM1.Codec?

  defmacro ok value, other do
    quote do
      {:ok, {__MODULE__, unquote(value), unquote(other)}}
    end
  end

  defmacro error reason, other do
    quote do
      {:error, {__MODULE__, unquote(reason), unquote(other)}}
    end
  end

  defmacro value result, fun do
    quote do
      {x, {_,          value,                y}} = unquote(result)
      {x, {__MODULE__, unquote(fun).(value), y}}
    end
  end

  defmacro other result, other do
    quote do
      {x, {_,          y, _             }} = unquote(result)
      {x, {__MODULE__, y, unquote(other)}}
    end
  end

  def error? {:error, {_, _, _}} do
    true
  end

  def error? _ do
    false
  end

  def error {:error, { _, error,_}} do
    error
  end

  def error _ do
    nil
  end

  def value {_, {_, value, _}} do
    value
  end

  # Guards
  defp is_integer value, min, max do
    quote do
      is_integer(unquote value) and unquote(value) >= unquote(min) and unquote(value) <= unquote(max)
    end
  end

  defmacro is_short_length value do
    is_integer value, 0, 30
  end

  defmacro is_short_integer value do
    is_integer value, 0, 127
  end

  defmacro is_short_integer_byte value do
    is_integer value, 128, 255
  end

  defmacro is_byte value do
    is_integer value, 0, 255
  end

  defmacro is_uintvar value do
    max_uint32 = 0xffffffff
    is_integer value, 0, max_uint32
  end

  defmacro is_long_integer value do
    thirty_0xffs = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    is_integer value, 0, thirty_0xffs
  end

  defmacro is_text value do
    quote do
      unquote(value) == 0 or unquote(value) >= 32
    end
  end
end

