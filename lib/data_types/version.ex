defmodule MMS.VersionInteger do
  use MMS.Codec

  def decode <<1::1, major::3, 15::4, rest::binary>> do
    ok major, rest
  end

  def decode <<1::1, major::3, minor::4, rest::binary>> do
    ok {major, minor}, rest
  end

  def encode(major) when is_integer(major, 0, 7) do
    do_encode major, 15
  end

  def encode({major, minor}) when is_integer(major, 0, 7) and is_integer(minor, 0, 14) do
    do_encode major, minor
  end

  def do_encode major, minor do
    ok <<1::1, major::3, minor::4>>
  end

  defaults()
end

defmodule MMS.Version do
  use MMS.Codec, either: [MMS.VersionInteger, MMS.Text]
end
