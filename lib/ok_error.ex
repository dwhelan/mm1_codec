defmodule MMS.OkError do

  defmacro ok value, rest do
    quote do
      {:ok, unquote({value, rest})}
    end
  end

  defmacro ok value do
    quote do
      {:ok, unquote(value)}
    end
  end

  defmacro error reason do
    quote do
      {:error, unquote(reason)}
    end
  end

  defmacro error codec, reason do
    quote do
      {:error, {unquote(codec), unquote(reason)}}
    end
  end
end

