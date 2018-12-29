defmodule MMS.Address.PhoneNumber do
  import MMS.OkError
  import MMS.Address.Email

  def map string do
    case is_phone_number? string do
      true  -> ok string
      false -> error :invalid_phone_number
    end
  end

  def unmap value do
    case is_phone_number? value do
      true  -> ok value <> "/TYPE=PLMN"
      false -> error :invalid_phone_number
    end
  end

  def is_phone_number? value do
    is_binary(value) && !is_email?(value)
  end
end
