defmodule MMS.LongInteger do
  @moduledoc """
  8.4.2.1 Basic rules

  Long-integer = Short-length Multi-octet-integer

  The Short-length indicates the length of the Multi-octet-integer

  Multi-octet-integer = 1*30 OCTET
  The content octets shall be an unsigned integer value with the most significant octet
  encoded first (big-endian representation).
  The minimum number of octets must be used to encode the value.
  """
  use MMS.Codec

  alias MMS.ShortLength

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> ShortLength.decode
    ~> decode_multi_octet_integer
    ~>> & error bytes, &1
  end

  defp decode_multi_octet_integer {_length = 0, _bytes} do
    error :must_have_at_least_one_data_byte
  end

  defp decode_multi_octet_integer {length, bytes} do
    bytes
    |> String.split_at(length)
    ~> fn {integer_bytes, rest} ->
         integer_bytes
         |> :binary.decode_unsigned
         |> ok(rest) end
  end

  def encode(value) when is_long(value) do
    value
    |> :binary.encode_unsigned
    ~> fn value_bytes ->
         value_bytes
         |> byte_size
         |> ShortLength.encode
         ~> & &1 <> value_bytes
       end
  end

  def encode value do
    error value, :out_of_range
  end
end
