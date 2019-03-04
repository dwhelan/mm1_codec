defmodule MMS.Media do
  use MMS.Codec

  alias MMS.{Text, WellKnownMedia}

  def decode(<<char, _ :: binary>> = bytes) when is_text(char) do
    bytes |> decode_with(Text)
  end

  def decode bytes do
    bytes |> decode_with(WellKnownMedia)
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_with(WellKnownMedia)
    ~>> fn _ -> string |> encode_with(Text) end
  end
end
