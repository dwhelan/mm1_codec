defmodule MMS.From do
  import MMS.OkError

  alias MMS.{Composer, Length, Byte, EncodedString}

  @address_present_token 128
  @insert_address_token  129

  def decode bytes do
    case_ok Composer.decode bytes, {Byte, EncodedString} do
      {{@address_present_token, address}, rest} -> ok address, rest
      {{@insert_address_token          }, rest} -> ok :insert_address_token, rest
      {{invalid_token, address         }, rest} -> error :address_token_must_be_128_to_129
    end
  end

  def encode :insert_address_token do
    ok <<1, @insert_address_token>>
  end

  def encode string do
    Composer.encode {@address_present_token, string}, {Byte, EncodedString}
  end
end
