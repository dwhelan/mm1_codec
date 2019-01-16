defmodule Codec do
  import OkError

  def ok value, other do
    ok {value, other}
  end

  def error reason, other do
    error {reason, other}
  end

  defmacro __using__ _ do
    quote do
      import OkError
      import Codec
      import CodecError
      import MMS.{DataTypes}
    end
  end
end

defmodule MMS.Byte do
  use Codec

  def decode <<byte, rest::binary>> do
    ok byte, rest
  end

  def encode(value) when is_byte(value) do
    ok <<value>>
  end

  def encode(_)  do
    module_error()
  end
end
