defmodule MMS.OkError do

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
end

