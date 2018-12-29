defmodule MMS.Address.Unknown do
  import MMS.OkError

  def map(value) when is_binary(value) do
    case String.split value, "/TYPE=", parts: 2 do
      [string, type] -> ok {string, type}
      _              -> error :invalid_unknown_address
    end
  end

  def map _ do
    error :invalid_unknown_address
  end

  def unmap({value, type}) when is_binary(value) and is_binary(type) do
    ok value <> "/TYPE=#{type}"
  end

  def unmap _ do
    error :invalid_unknown_address
  end
end
