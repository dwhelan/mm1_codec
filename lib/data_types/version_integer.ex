defmodule MMS.VersionInteger do
  @moduledoc """
  8.4.2.3 Parameter Values

  Version-value = Short-integer | Text-string

  This codec is responsible for interpreting the major and minor versions for a Short-integer version.

  The three most significant bits of the Short-integer value are interpreted to encode a major version number in the range 1-7,
  and the four least significant bits contain a minor version number in the range 0-14.

  If there is only a major version number, this is encoded by placing the value 15 in the four least significant bits.
  If the version to be encoded fits these constraints, a Short-integer must be used, otherwise a Text-string shall be used.
  """
  use MMS.Codec

  @major_range 0..7
  @minor_range 0..14
  @no_minor    15

  def decode <<1::1, major::3, @no_minor::4, rest::binary>> do
    ok major, rest
  end

  def decode <<1::1, major::3, minor::4, rest::binary>> do
    ok {major, minor}, rest
  end

  def decode bytes = <<version, _::binary>> do
    error bytes, out_of_range: version
  end

  def encode(major) when major in @major_range do
    {major, @no_minor}
    |> do_encode
  end

  def encode({major, minor}) when major in @major_range and minor in @minor_range do
    {major, minor}
    |> do_encode
  end

  def encode({major, minor}) when is_integer(major) and minor in @minor_range do
    error {major, minor}, :major_out_of_range
  end

  def encode({major, minor}) when is_integer(major) and is_integer(minor) do
    error {major, minor}, :minor_out_of_range
  end

  def encode(major) do
    error major, :out_of_range
  end

  def do_encode {major, minor} do
    <<1::1, major::3, minor::4>>
    |> ok
  end
end
