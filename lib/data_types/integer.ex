defmodule MMS.Integer do
  use MMS.Codec2

  alias MMS.{Short, Long}

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> do_decode
    ~>> fn details -> error bytes, error_detail_list(details) end
  end

  defp do_decode bytes = <<1::1, _::7, _::binary>> do
    bytes |> Short.decode
  end

  defp do_decode bytes do
    bytes |> Long.decode
  end

  def encode(value) when is_integer(value) do
    value
    |> do_encode
    ~>> fn details -> error value, details end
  end

  def encode value do
    error value, :invalid_integer
  end

  def do_encode(value) when is_short(value) do
    value |> Short.encode
  end

  def do_encode value do
    value |> Long.encode
  end
end
