defmodule MMS.MediaType do
  @moduledoc """
  8.4.2.24 Content type field

  Media-type = (Well-known-media | Extension-Media) *(Parameter)
  """
  use MMS.Codec

  alias MMS.{WellKnownMedia, ExtensionMedia}

  def decode bytes do
    bytes
    |> decode_either([WellKnownMedia, ExtensionMedia])
  end

  def encode(atom) when is_atom(atom) do
    atom
    |> encode_as(WellKnownMedia)
  end

  def encode(string) when is_binary(string) do
    string
    |> encode_as(ExtensionMedia)
  end
end
