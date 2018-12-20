defmodule MMS.Address.PhoneNumber do
  import MMS.OkError

  def map string do
    case MMS.Address.Email.is_email? string do
      false -> ok string
      true  -> error :invalid_phone_number
    end
  end

  def unmap value do
    value <> "/TYPE=PLMN"
  end
end
