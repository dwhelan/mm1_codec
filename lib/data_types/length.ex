defmodule MMS.Length do
  @moduledoc """
  Specification: WAP-230230-WSP-20010705-a, 8.4.2.2 Length
The following rules are used to encode length indicators.
Value-length = Short-length | (Length-quote Length)
; Value length is used to indicate the length of the value to follow
Short-length = <Any octet 0-30> Length-quote = <Octet 31> Length = Uintvar-integer
  """
  use MMS.Codec

  alias MMS.Uint32

  # TODO: return error if insufficient bytes
  def decode(bytes = <<length_quote, rest::binary>>) when is_length_quote(length_quote) do
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
    ~> fn bytes -> <<length_quote()>> <> bytes end
    ~>> & value |> encode_error(&1)
  end
end
