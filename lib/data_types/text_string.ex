defmodule MMS.TextString do
  use MMS.Codec
  import OkError.Module

  alias MMS.Text

  @quote 127

  def decode(<<@quote, byte, _::binary>> = bytes) when byte >= 128 do
    bytes |> Text.decode <~> String.slice(1..-1)
  end

  def decode(<<byte, _::binary>> = bytes) when is_char(byte) and byte != @quote do
    bytes |> Text.decode ~>> module_error
  end

  def encode(<<byte, _::binary>> = string) when byte >= 128 do
    string |> prepend(<<@quote>>) |> Text.encode
  end

  def encode(string) when is_binary(string) do
    string |> Text.encode
  end

  defaults()
end
