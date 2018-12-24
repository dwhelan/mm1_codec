defmodule MMS.Byte do
  import MMS.OkError
  import MMS.DataTypes

  def decode <<byte, rest::binary>> do
    ok byte, rest
  end

  def encode(value) when is_byte(value) do
    ok <<value>>
  end

  def encode _ do
    error :invalid_byte
  end
end
