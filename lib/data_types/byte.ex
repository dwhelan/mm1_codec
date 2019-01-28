defmodule Codec do
  import OkError

  def ok value, other do
    ok {value, other}
  end

  def error reason, other do
    error {reason, other}
  end

  def return({:ok, value}, module), do:  {:ok, value}
  def return {:error, reason}, module do
    {:error, name(module)}
  end

  def encode_error module do
    module |> error_name |> error
  end

  def error_name module do
    "invalid_#{name module}" |> String.to_atom
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
    encode_error(__MODULE__)
  end
end

defmodule MMS.Byte do
  defmodule Decode do
    use Codec.Decode

    @spec decode(binary) :: OkError.ok
    def decode <<byte, rest::binary>> do
      ok byte, rest
    end
  end

  defmodule Encode do
    use Codec.Encode

    @spec encode(byte) :: OkError.ok
    def encode(byte) when is_byte(byte) do
      ok <<byte>>
    end

    @spec encode(any) :: OkError.error
    def encode value do
      error :invalid_byte, value
    end
  end
end


