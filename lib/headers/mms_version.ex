defmodule MMS.MMSVersion do
  import MMS.OkError
  alias MMS.Short

  def decode <<1::1, major::3, minor::4, rest::binary>> do
    ok "#{major}.#{minor}", rest
  end

  def encode version do
    do_encode String.split version, "."
  end

  defp do_encode [major, minor] do
    ok <<1::1, major(major)::3, minor(minor)::4>>
  end

  defp major string do
    major = String.to_integer string
  end

  defp minor string do
    minor = String.to_integer string
  end
end
