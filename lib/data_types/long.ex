defmodule MMS.Long do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Long-integer = ShortInteger-length Multi-octet-integer
    The ShortInteger-length indicates the length of the Multi-octet-integer
  """
  use MMS.Codec2

  alias MMS.ShortLength
  alias MMS.Long.MultiOctetInteger

  def decode(bytes) when is_binary(bytes) do
    bytes
    |> ShortLength.decode
    ~> MultiOctetInteger.decode
    ~>> & decode_error bytes, &1
  end

  def encode(value) when is_long(value) do
    value
    |> MultiOctetInteger.encode
    ~> fn value_bytes ->
         value_bytes
         |> byte_size
         |> ShortLength.encode
         ~> & &1 <> value_bytes
       end
  end

  def encode value do
    value |> encode_error(:out_of_range)
  end

  defmodule MultiOctetInteger do
    @moduledoc """
      Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

      Multi-octet-integer = 1*30 OCTET
      The content octets shall be an unsigned integer value with the most significant octet
      encoded first (big-endian representation).
      The minimum number of octets must be used to encode the value.
    """
    use MMS.Codec2

    @doc "Assumes sufficient bytes"
    def decode({0, bytes}) when is_binary(bytes) do
      bytes |> error(:must_have_at_least_one_data_byte)
    end

    def decode({length, bytes}) when is_short_length(length) do
      bytes
      |> String.split_at(length)
      ~> fn {integer_bytes, rest} -> integer_bytes |> :binary.decode_unsigned |> decode_ok(rest) end
    end

    def encode(value) when is_long(value) do
      value |> :binary.encode_unsigned
    end

    def encode value do
      value |> encode_error(:out_of_range)
    end
  end
end
