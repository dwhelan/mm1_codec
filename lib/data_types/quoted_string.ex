defmodule MMS.QuotedString do
  use MMS.Codec

  alias MMS.Text

  def decode <<?", bytes::binary>> do
    bytes |> Text.decode ~> map_value(tokenize)
  end

  defp tokenize value do
    {value}
  end

  def encode({string}) when is_binary(string) do
    string |> Text.encode ~> prefix(?")
  end

  defaults()
end
