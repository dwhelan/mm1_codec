defmodule MMS.MessageClass do
  import OkError

  alias MMS.{Lookup, Short, Text}

  @decode_map OkError.Map.from_list [:personal, :advertisement, :informational, :auto]
  @encode_map OkError.Map.invert @decode_map

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
