defmodule MMS.MessageClass do
  alias MMS.{Lookup, Byte, Text}

  @decode_map Lookup.indexed [:personal, :advertisement, :informational, :auto]
  @encode_map MMS.Mapper.reverse @decode_map

  def decode(<<value, _::binary>> = bytes) when value >= 128 do
    Lookup.decode bytes, Byte, @decode_map
  end

  def decode bytes do
    Text.decode bytes
  end

  def encode(value) when is_binary(value) do
    Text.encode value
  end

  def encode value do
    Lookup.encode value, Byte, @encode_map
  end
end
