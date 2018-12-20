defmodule MMS.MessageClass do
  alias MMS.{Mapper, Short, String}

  @decode_map Mapper.indexed [:personal, :advertisement, :informational, :auto]
  @encode_map Mapper.reverse @decode_map

  def decode(<<value, _::binary>> = bytes) when value >= 128 do
    bytes |> Mapper.decode(Short, @decode_map)
  end

  def decode bytes do
    bytes |> String.decode
  end

  def encode(value) when is_atom(value) do
    value |> Mapper.encode(Short, @encode_map)
  end

  def encode value do
    value |> String.encode
  end
end
