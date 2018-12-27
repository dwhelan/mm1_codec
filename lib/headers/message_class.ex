defmodule MMS.MessageClass do
  alias MMS.{Mapper, Byte, Text}

  @decode_map Mapper.indexed [:personal, :advertisement, :informational, :auto], 128
  @encode_map Mapper.reverse @decode_map

  def decode(<<value, _::binary>> = bytes) when value >= 128 do
    Mapper.decode bytes, Byte, @decode_map
  end

  def decode bytes do
    Text.decode bytes
  end

  def encode(value) when is_binary(value) do
    Text.encode value
  end

  def encode value do
    Mapper.encode value, Byte, @encode_map
  end
end
