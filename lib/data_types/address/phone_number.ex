defmodule MMS.Address.PhoneNumber do
  import MMS.OkError
  import MMS.Address.Email

  def map string do
    IO.inspect string
    case is_phone_number? string do
      true  -> ok string
      false -> error :invalid_phone_number
    end
  end

  def unmap value do
    value <> "/TYPE=PLMN"
  end

  def is_phone_number? value do
    is_binary(value) && !is_email?(value)
  end
end
