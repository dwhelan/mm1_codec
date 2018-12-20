defmodule MMS.MMSVersion do
  import MMS.OkError

  def decode <<1::1, major::3, 15::4, rest::binary>> do
    ok "#{major}", rest
  end

  def decode <<1::1, major::3, minor::4, rest::binary>> do
    ok "#{major}.#{minor}", rest
  end

  def encode version do
    case do_encode String.split version, "." do
      {major, minor} -> ok <<1::1, major::3, minor::4>>
      :error         -> error :invalid_version_string
    end
  end

  defp do_encode [major, minor] do
    with major when is_integer(major) <- to_int(major,  7),
         minor when is_integer(minor) <- to_int(minor, 14)
    do
      {major, minor}
    end
  end

  defp do_encode [major] do
    with major when is_integer(major) <- to_int(major, 7)
    do
      {major, 15}
    end
  end

  defp to_int string, max do
    case String.to_integer string do
      value when is_integer(value) and value >=0 and value <= max -> value
      _ -> :error
    end
  end
end
