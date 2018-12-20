defmodule MMS.OkError do

  def ok value, rest do
    {:ok, {value, rest}}
  end

  def ok value do
    {:ok, value}
  end

  def error codec, reason do
    {:error, {codec, reason}}
  end

  def error reason do
    {:error, reason}
  end

  defmacro case_ok value, do: block do
    quote do
      case unquote(value) do
        {:ok,value} -> case value, do: unquote(block)
        error       -> error
      end
    end
  end
end
