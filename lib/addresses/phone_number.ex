defmodule MMS.PhoneNumber do
  use MMS.Address.Base, type: "PLMN"

  def map_address phone_number do
    ok_if phone_number
  end

  def unmap_address phone_number do
    ok_if phone_number
  end

  defp ok_if phone_number do
    if is_binary(phone_number) && String.match?(phone_number, ~r/^\+?[\d\-\.]+$/) do
      ok phone_number
    else
      module_error()
    end
  end
end
