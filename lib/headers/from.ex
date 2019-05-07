defmodule MMS.From.Address do
  @moduledoc """
  7.2.11 From field
  From-value = Value-length (Address-present-token Encoded-string-value | Insert-address-token)

  We define From-address as
  From-address = Address-present-token Encoded-string-value | Insert-address-token

  Address-present-token = <Octet 128>
  Insert-address-token  = <Octet 129>
  """

  @insert_address_token 129

  use MMS.Codec
  import MMS.As
  alias MMS.{ShortInteger, Address}

  def decode <<128, rest::binary>> do
    rest
    |>decode_as(Address)
  end

  def decode <<@insert_address_token, rest::binary>> do
    ok :insert_address_token, rest
  end

  def encode(from) when is_address(from) do
    from
    |> encode_as(Address)
  end

  def encode(:insert_address_token) do
    ok <<@insert_address_token>>
  end

  def encode value do
    error value, :bad_data_type
  end
end

defmodule MMS.From do
  @moduledoc """
  7.2.11 From field
  From-value = Value-length (Address-present-token Encoded-string-value | Insert-address-token)

  Address-present-token = <Octet 128>
  Insert-address-token  = <Octet 129>
  """

  use MMS.Codec
  import MMS.As
  alias MMS.{ValueLength, ShortInteger, Address}

  @map %{
    0 => Address,
    1 => :insert_address_token,
  }

  def decode bytes do
    bytes
    |> ValueLength.decode(
         fn value_bytes ->
           value_bytes
           |> decode_as(ShortInteger, @map)
         end
       )
#    ~>> fn {data_type, _, details} -> error bytes, [{data_type, details}]  end
  end

  def encode(from) when is_address(from) or from == :insert_address_token do
    from
    |> ValueLength.encode(
         fn value ->
           value
           |> encode_as(ShortInteger, @map, Address)
         end
       )
  end

  def encode value do
    error value, :bad_data_type
  end
end
