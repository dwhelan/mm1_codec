defmodule MMS.QuotedString do
  use MMS.Codec
  alias MMS.Text

  @quote ~S(")

  def decode << @quote, _::binary >> = bytes do
    bytes |> Text.decode <~> append(@quote)
  end

  def encode << @quote, _::binary >> = string do
    if string |> String.ends_with?(@quote) do
      string |> String.slice(0..-2) ~> Text.encode
    else
      error()
    end
  end

  defaults()
end
