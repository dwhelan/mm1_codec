defmodule MMS.QuotedString do
  use MMS.Codec

  alias MMS.Text

  def decode << ~S("), _::binary >> = bytes do
    bytes |> Text.decode <~> append(~S("))
  end

  def encode(string) when is_binary(string) do
    string |> ensure_quoted ~> remove_trailing(1) ~> Text.encode
  end

  defp ensure_quoted string do
    if is_quoted?(string), do: ok(string), else: error()
  end

  defp is_quoted? string do
    String.starts_with?(string, ~S(")) and String.ends_with?(string, ~S("))
  end

  defaults()
end
