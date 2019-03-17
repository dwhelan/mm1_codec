defmodule MMS.Media do
  use MMS.Codec

  alias MMS.{WellKnownMedia, ExtensionMedia}

  def decode(bytes = <<well_known_media, _::binary>>) when is_short_integer_byte(well_known_media) do
    bytes
    |> decode_as(WellKnownMedia)
  end

  def decode(<<char, _ :: binary>> = bytes) when is_text(char) do
    bytes
    |> decode_as(ExtensionMedia)
  end

  def decode bytes do
    bytes
    |> decode_error(:must_start_with_a_short_integer_or_char)
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_as(WellKnownMedia)
    ~>> fn _ ->
          string
          |> encode_as(ExtensionMedia)
        end
  end
end
