defmodule MMS.Length do
  use MMS.Codec2, error: :invalid_length

  @length_quote 31

  alias MMS.Uint32

  def decode bytes = <<@length_quote, rest::binary>> do
    rest
    |> Uint32.decode
    ~>> fn details -> error :invalid_length, bytes, details end
  end

  def decode(bytes) when is_binary(bytes) do
    error :invalid_length, bytes, :missing_length_quote
  end

  def encode value do
    value
    |> Uint32.encode
    ~> fn bytes -> <<@length_quote>> <> bytes end
    ~>> fn details -> error :invalid_length, value, details end
  end
end
