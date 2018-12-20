defmodule MMS.From do
  import MMS.OkError

  alias MMS.{Composer, Length, Byte, EncodedString}

  @address_present_token 128
  @insert_address_token  129

  def decode bytes do
    case bytes |> Composer.decode {Byte, EncodedString} do
      {:ok, {{@address_present_token, address}, rest}} -> ok address, rest
      {:ok, {{@insert_address_token          }, rest}} -> ok :insert_address_token, rest
      {:ok, {{invalid_token, address         }, rest}} -> error :address_token_must_be_128_to_129
      error -> error
    end
  end

  def encode(string) when is_binary(string) do
    with {:ok, string_bytes} <- EncodedString.encode(string),
         {:ok, length_bytes} <- Length.encode(1 + byte_size(string_bytes))
    do
      ok length_bytes <> <<@address_present_token>> <> string_bytes
    else
      error -> error
    end
  end

  def encode :insert_address_token do
    ok <<1, @insert_address_token>>
  end
end
