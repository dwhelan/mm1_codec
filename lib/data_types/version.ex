defmodule MMS.VersionInteger do
  use MMS.Codec

  def decode <<1::1, major::3, 15::4, rest::binary>> do
    ok major, rest
  end

  def decode <<1::1, major::3, minor::4, rest::binary>> do
    ok {major, minor}, rest
  end

  def encode(major) when is_major_version(major) do
    do_encode major, 15
  end

  def encode({major, minor}) when is_major_version(major) and is_minor_version(minor) do
    do_encode major, minor
  end

  def do_encode major, minor do
    ok <<1::1, major::3, minor::4>>
  end

  defaults()
end

defmodule MMS.Version do
  use MMS.Either, [MMS.VersionInteger, MMS.Text]
end
