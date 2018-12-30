defmodule MMS.Address.PhoneNumber do
  use MMS.Address.Base, type: "PLMN"
  import MMS.OkError

  def map_address string do
    check_phone_number string
  end

  def unmap_address value do
    check_phone_number value
  end

  defp check_phone_number value do
    if is_binary(value) && Regex.match?(~r/^\+?[\d\-\.]+$/, value) do
      ok value
    else
      error()
    end
  end
end
