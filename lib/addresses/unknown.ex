defmodule MMS.Address.Unknown do
  use MMS.Mapper.Base, error: :invalid_unknown_address
  import MMS.OkError

#  def map_address {string, type} do
#    {string, type}
#  end
#
#  def unmap_address {string, type} do
#    :inet.ntoa ipv4
#  end

  def map(value) when is_binary(value) do
    case String.split value, "/TYPE=", parts: 2 do
      [string, type] -> ok {string, type}
      _              -> error()
    end
  end

  def map _ do
    error()
  end

  def unmap({value, type}) when is_binary(value) and is_binary(type) do
    ok value <> "/TYPE=#{type}"
  end

  def unmap _ do
    error()
  end
end
