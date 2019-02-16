defmodule MMS.QuotedString do
  use MMS.Codec

  alias MMS.Text

  def decode bytes = << ~s("), _::binary >> do
    bytes |> Text.decode <~> append(~s("))
  end

  def encode(string) when is_binary(string) do
    cond do
      is_quoted? string -> string |> remove_trailing_quote ~> Text.encode
      true              -> module_error()
    end
  end

  defp is_quoted? string do
    String.starts_with?(string, ~s(")) and String.ends_with?(string, ~s("))
  end

  defp remove_trailing_quote string do
    string |> String.slice(0..-2)
  end

  defaults()
end
