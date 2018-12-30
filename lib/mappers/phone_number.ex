defmodule MMS.PhoneNumber do
  use MMS.Address.Base, type: "PLMN"
  import MMS.OkError

  def map_address string do
    return_if_phone_number string
  end

  def unmap_address value do
    return_if_phone_number value
  end

  defp return_if_phone_number value do
    if is_binary(value) && Regex.match?(~r/^\+?[\d\-\.]+$/, value) do
      ok value
    else
      error()
    end
  end
end
