defmodule MMS.ConstrainedEncoding do
  @moduledoc """
  8.4.2.1 Basic rules

  Constrained-encoding = Extension-Media | Short-integer

  This encoding is used for token values, which have no well-known binary encoding, or when
  the assigned number of the well-known encoding is small enough to fit into Short-integer.
  """
  use MMS.Codec

  alias MMS.{ExtensionMedia, ShortInteger}

  def decode(<<char, _ :: binary>> = bytes) when is_text(char) do
    bytes
    |> decode_as(ExtensionMedia)
  end

  def decode(bytes = <<well_known_media, _::binary>>) when is_short_integer_byte(well_known_media) do
    bytes
    |> decode_as(ShortInteger)
  end

  def decode bytes do
    bytes
    |> decode_error(:must_start_with_a_short_integer_or_char)
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_as(ExtensionMedia)
  end

  def encode(short_integer) when is_short_integer(short_integer) do
    short_integer
    |> encode_as(ShortInteger)
  end
end
