defmodule WAP.Guards do
  # Should be in MM1.Codec?

  defmacro map_value foo, map do
    quote bind_quoted: [foo: foo, map: map] do
      {result, {value,       _,          rest}} = foo
      {result, {map.(value), __MODULE__, rest}}
    end
  end

  defmacro unmap_encode value, codec, unmap do
    quote bind_quoted: [value: value, codec: codec, unmap: unmap] do
      {result, {x, _,          _    }} = value |> unmap.() |> codec.encode
      {result, {x, __MODULE__, value}}
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

