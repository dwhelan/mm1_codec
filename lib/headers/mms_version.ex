defmodule MMS.MMSVersion do
  import MMS.OkError
  alias MMS.Short

  def decode <<1::1, major::3, 15::4, rest::binary>> do
    ok "#{major}", rest
  end

  def decode <<1::1, major::3, minor::4, rest::binary>> do
    ok "#{major}.#{minor}", rest
  end

  def encode version do
    do_encode String.split version, "."
  end

  defp do_encode [major, minor] do
    with major when is_integer(major) <- int(major,  7),
         minor when is_integer(minor) <- int(minor, 14)
    do
      ok <<1::1, major::3, minor::4>>
    else
      _ -> error :invalid_version_string
    end
  end

  defp do_encode [major] do
    with major when is_integer(major) <- int(major,  7)
    do
      ok <<1::1, major::3, 15::4>>
    else
      _ -> error :invalid_version_string
    end
  end

  defp int string, max do
    string |> String.to_integer |> check_max(max)
  end

  defp check_max value, max do
    if value >=0 && value <= max, do: value, else: :error
  end
end
