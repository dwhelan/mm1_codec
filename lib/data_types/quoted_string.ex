defmodule MMS.QuotedString do
  use MMS.Codec

  alias MMS.Text

  def decode <<?", _::binary>> = bytes do
    bytes |> Text.decode ~> map_value(suffix ?")
  end

  def encode(string) when is_binary(string) do
    if is_quoted? string do
      string |> unquote_string |> Text.encode
    else
      error()
    end
  end

  defp unquote_string string do
    string |> String.slice(0..-2)
  end

  defp is_quoted? string do
    String.starts_with?(string, ~S(")) and String.ends_with?(string, ~S("))
  end

  defaults()
end
