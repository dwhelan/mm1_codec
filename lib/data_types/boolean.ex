defmodule MMS.Boolean do
  use MMS.Codec2
  import Codec.Map

  def decode bytes = <<128, rest::binary>> do
    ok true, rest
  end

  def decode bytes = <<129, rest::binary>> do
    ok false, rest
  end

  def decode(bytes) when is_binary(bytes) do
    error bytes, :out_of_range
  end

  def encode true do
    ok <<128>>
  end

  def encode false do
    ok <<129>>
  end
end
