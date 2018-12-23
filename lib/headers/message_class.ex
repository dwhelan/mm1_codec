defmodule MMS.MessageClass do
  alias MMS.{Mapper, Byte, String}

  @decode_map Mapper.indexed [:personal, :advertisement, :informational, :auto], 128
  @encode_map Mapper.reverse @decode_map

  def decode(<<value, _::binary>> = bytes) when value >= 128 do
    bytes |> Mapper.decode(Byte, @decode_map)
  end

  def decode bytes do
    bytes |> String.decode
  end

  def encode(value) when is_binary(value) do
    value |> String.encode
  end

  def encode value do
    value |> Mapper.encode(Byte, @encode_map)
  end
end
