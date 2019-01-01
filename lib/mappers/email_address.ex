defmodule MMS.Mapper.EmailAddress do
  import MMS.OkError

  def map string do
    ok_if string
  end

  def unmap email do
    ok_if email
  end

  defp ok_if email do
    if is_binary(email) && String.contains?(email, "@") && !String.contains?(email, "/TYPE=") do
      ok email
    else
      error()
    end
  end
end
