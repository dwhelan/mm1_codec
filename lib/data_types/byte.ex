defmodule MMS.Byte do
  import MMS.OkError
  import MMS.DataTypes

  def decode <<value, rest::binary>> do
    ok value, rest
  end

  def encode(value) when is_byte(value) do
    ok <<value>>
  end

  def encode _ do
    error :must_be_an_integer_between_0_and_255
  end
end
