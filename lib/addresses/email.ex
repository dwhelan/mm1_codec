defmodule MMS.Address.Email do
  import MMS.OkError

  def map string do
    case is_email? string do
      true  -> ok string
      false -> error :invalid_email
    end
  end

  def unmap value do
    value
  end

  def is_email? string do
    String.contains? string, "@"
  end
end