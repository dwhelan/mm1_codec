defmodule MMS.Boolean do
  use MMS.Codec2
  import Codec.Map

  @map Codec.Map.with_index [true, false]

  def decode bytes = <<1::1, value::7, rest::binary>> do
    {value, rest}
    |> map(@map)
    ~>> fn details -> error bytes, details end
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :not_found
  end

  @inverse invert @map

  def encode(value) when is_boolean(value) do
    value
    |> map(@inverse)
    ~> fn result -> ok <<result+128>> end
  end
end
