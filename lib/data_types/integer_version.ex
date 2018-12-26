defmodule MMS.IntegerVersion do
  import MMS.OkError
  import MMS.DataTypes

  def decode <<1::1, major::3, 15::4, rest::binary>> do
    ok major, rest
  end

  def decode <<1::1, major::3, minor::4, rest::binary>> do
    ok {major, minor}, rest
  end

  def encode(major) when is_integer(major, 0, 7) do
    ok <<1::1, major::3, 15::4>>
  end

  def encode({major, minor}) when is_integer(major, 0, 7) and is_integer(minor, 0, 14) do
    ok <<1::1, major::3, minor::4>>
  end

  def encode _ do
    error :invalid_version
  end
end
