defmodule MMS.Mapper.EmailAddress do
  import MMS.OkError

  def map email do
    ok_if email
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
