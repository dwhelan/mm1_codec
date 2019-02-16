defmodule MMS.QuotedString do
  use MMS.Codec

  alias MMS.Text

  def decode(<<quote, _::binary >> = bytes) when is_quote(quote) do
    bytes |> Text.decode <~> append(quote_string())
  end

  def encode(string) when is_binary(string) do
    cond do
      is_quoted? string -> string |> remove_trailing_quote ~> Text.encode
      true              -> module_error()
    end
  end

  defp is_quoted? string do
    String.starts_with?(string, quote_string()) and String.ends_with?(string, quote_string())
  end

  defp remove_trailing_quote string do
    string |> String.slice(0..-2)
  end

  defaults()
end
