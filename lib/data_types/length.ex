defmodule MMS.Length do
  use MMS.Codec2

  @length_quote 31

  alias MMS.Uint32

  # TODO: return error if insufficient bytes
  def decode bytes = <<@length_quote, rest::binary>> do
    rest
    |> Uint32.decode
    ~>> & bytes |> decode_error(&1)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_error(:missing_length_quote)
  end

  def encode value do
    value
    |> Uint32.encode
    ~> fn bytes -> <<@length_quote>> <> bytes end
    ~>> & value |> encode_error(&1)
  end
end
