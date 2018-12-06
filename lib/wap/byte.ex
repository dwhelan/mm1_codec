defmodule WAP.Byte do
  use MM1.Codecs.Base

  def decode <<value, rest::binary>> do
    decode_ok value, <<value>>, rest
  end

  def new(value) when is_byte(value) do
    new_ok value, <<value>>
  end

  def new value do
    new_error :must_be_an_integer_between_0_and_255, value
  end
end

defmodule WAP2.Byte do
  import WAP.Guards

  def decode <<value, rest::binary>> do
    {:ok, value, rest}
  end

  def encode(value) when is_byte(value) do
    {:ok, <<value>>}
  end

  def encode value do
    {:err, :must_be_an_integer_between_0_and_255}
  end
end
