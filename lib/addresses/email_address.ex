defmodule MMS.EmailAddress do
  import OkError
  import OkError.Module

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
      module_error()
    end
  end
end
