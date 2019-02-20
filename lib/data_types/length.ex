defmodule MMS.Length do
  use MMS.Codec2

  @length_quote 31

  alias MMS.Uint32

  def decode bytes = <<@length_quote, rest::binary>> do
    rest
    |> Uint32.decode
    ~>> fn details -> decode_error bytes, details end
  end

  def decode(bytes) when is_binary(bytes) do
    decode_error bytes, :missing_length_quote
  end

  def encode value do
    value
    |> Uint32.encode
    ~> fn bytes -> <<@length_quote>> <> bytes end
    ~>> fn details -> error value, details end
  end
end
