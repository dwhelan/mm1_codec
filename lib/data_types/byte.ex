defmodule Codec do
  import OkError

  def ok value, other do
    ok {value, other}
  end

  def error reason, other do
    error {reason, other}
  end

  def name module do
    module
    |> to_string
    |> String.split(".")
    |> List.last
    |> Codec.String.pascalcase
    |> Macro.underscore
    |> String.to_atom
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
    encode_error()
  end
end
