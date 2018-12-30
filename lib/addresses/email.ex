defmodule MMS.Address.Email do
  use MMS.Mapper.Base
  import MMS.OkError

  def map string do
    check_email string
  end

  def unmap value do
    check_email value
  end

  defp check_email value do
    if is_binary(value) && String.contains?(value, "@") && !String.contains?(value, "/TYPE=") do
      ok value
    else
      error()
    end
  end
end
