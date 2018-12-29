defmodule MMS.Address.Email do
  import MMS.OkError

  def map string do
    case is_email? string do
      true  -> ok string
      false -> error :invalid_email
    end
  end

  def unmap email do
    map email
  end

  def is_email?(string) when is_binary(string) do
    String.contains? string, "@"
  end

  def is_email? _ do
    false
  end
end
