defmodule MMS.EmailAddress do
  use MMS.Mapper.Base
  import MMS.OkError

  def map string do
    return_if_email string
  end

  def unmap value do
    return_if_email value
  end

  defp return_if_email value do
    if is_binary(value) && String.contains?(value, "@") && !String.contains?(value, "/TYPE=") do
      ok value
    else
      error()
    end
  end
end
