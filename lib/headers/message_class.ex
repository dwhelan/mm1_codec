defmodule MMS.MessageClass do
  import MMS.OkError

  alias MMS.{Lookup, Short, Text}

  @decode_map Lookup.indexed [:personal, :advertisement, :informational, :auto]
  @encode_map MMS.Mapper.reverse @decode_map

  def decode(<<value, _::binary>> = bytes) when value >= 128 do
    bytes |> Lookup.decode(Short, @decode_map) ~>> module_error
  end

  def decode bytes do
    Text.decode bytes
  end

  def encode(value) when is_binary(value) do
    Text.encode value
  end

  def encode value do
    Lookup.encode value, Short, @encode_map
  end
end
