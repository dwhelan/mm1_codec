defmodule MMS.From do
  import MMS.OkError

  alias MMS.{Composer, Byte, Address}

  @address_present_token 128
  @insert_address_token  129

  def decode bytes do
    case_ok Composer.decode bytes, [Byte, Address], allow_partial: true do
      {[@address_present_token, address], rest} -> ok address, rest
      {[@insert_address_token          ], rest} -> ok :insert_address_token, rest
      _                                         -> error :invalid_address_token
    end
  end

  def encode :insert_address_token do
    ok <<1, @insert_address_token>>
  end

  def encode string do
    Composer.encode [@address_present_token, string], [Byte, Address]
  end
end
