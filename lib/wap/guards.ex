defmodule WAP.Guards do
  # Should be in MM1.Codec?

  defmacro value result, fun do
    quote bind_quoted: [result: result, fun: fun] do
      {x, {value,       _,          y}} = result
      {x, {fun.(value), __MODULE__, y}}
    end
  end


  defmacro module result do
    quote do
      {x, {y, _,          z}} = unquote(result)
      {x, {y, __MODULE__, z}}
    end
  end

  defmacro other result, other do
    quote do
      {x, {y, _,          _             }} = unquote(result)
      {x, {y, __MODULE__, unquote(other)}}
    end
  end

  defmacro ok value, other do
    quote do
      {:ok, {unquote(value), __MODULE__, unquote(other)}}
    end
  end

  defmacro error reason, other do
    quote do
      {:error, {unquote(reason), __MODULE__, unquote(other)}}
    end
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

