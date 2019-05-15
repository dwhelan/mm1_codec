defmodule MMS.From do
  @moduledoc """
  7.2.11 From field
  From-value = Value-length (Address-present-token Encoded-string-value | Insert-address-token)
             = Value-length From-Address
  """
  import MMS.Length

  defcodec as: MMS.From.Address, length: MMS.ValueLength

  defmodule Address do
    @moduledoc """
    7.2.11 From field

    We define From-address as:

    From-address = Address-present-token Encoded-string-value | Insert-address-token

    Address-present-token = <Octet 128>
    Insert-address-token  = <Octet 129>
    """

    @address_present_token 128
    @insert_address_token  129

    use MMS.Codec
    import MMS.As
    alias MMS.Address

    def decode <<@address_present_token, rest::binary>> do
      rest
      |>decode_as(Address)
    end

    def decode <<@insert_address_token, rest::binary>> do
      ok :insert_address_token, rest
    end

    def decode bytes do
      error bytes, :out_of_range
    end

    def encode(from) when is_address(from) do
      from
      |> encode_as(Address)
      ~> fn bytes -> ok <<@address_present_token>> <> bytes end
    end

    def encode(:insert_address_token) do
      ok <<@insert_address_token>>
    end

    def encode value do
      error value, :bad_data_type
    end
  end
end
