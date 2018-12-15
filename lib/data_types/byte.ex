defmodule MMS.Byte do
  import MM1.OkError
  import MMS.DataTypes

  def decode <<value, rest::binary>> do
    ok {value, rest}
  end

  def encode(value) when is_byte(value) do
    ok <<value>>
  end

  def encode value do
    error :must_be_an_integer_between_0_and_255
  end
end
