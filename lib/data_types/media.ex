defmodule MMS.Media do
  use MMS.Codec

  alias MMS.{Text, WellKnownMedia}

  def decode(<<char, _ :: binary>> = bytes) when is_text(char) do
    bytes |> decode_as(Text)
  end

  def decode bytes do
    bytes |> decode_as(WellKnownMedia)
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_as(WellKnownMedia)
    ~>> fn _ -> string |> encode_as(Text) end
  end
end
