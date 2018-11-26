defmodule WAP.Byte do
  use MM1.BaseCodec
  import WAP.Guards
  import MM1.Result

  def decode <<value, rest::binary>> do
    ok value, <<value>>, rest
  end

  def new(value) when is_byte(value) do
    ok value, <<value>>
  end

  def new value do
    err value, :must_be_an_integer_between_0_and_255
  end
end
