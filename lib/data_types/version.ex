defmodule MMS.VersionInteger do
  use MMS.Codec2

  @no_minor 15

  def decode <<1::1, major::3, @no_minor::4, rest::binary>> do
    major |> decode_ok(rest)
  end

  def decode <<1::1, major::3, minor::4, rest::binary>> do
    {major, minor} |> decode_ok(rest)
  end

  def decode bytes = <<version, _rest::binary>> do
    bytes |> decode_error(%{out_of_range: version})
  end

  def encode(major) when major in 0..7 do
    {major, @no_minor} |> do_encode
  end

  def encode(major) when is_integer(major) do
    major |> encode_error(:out_of_range)
  end

  def encode({major, minor}) when major in 0..7 and minor in 0..14 do
    {major, minor} |> do_encode
  end

  def encode({major, minor}) when is_integer(major) and minor in 0..14 do
    {major, minor} |> encode_error(:major_out_of_range)
  end

  def encode({major, minor}) when is_integer(major) and is_integer(minor) do
    {major, minor} |> encode_error(:minor_out_of_range)
  end

  def do_encode {major, minor} do
    <<1::1, major::3, minor::4>> |> ok
  end
end

defmodule MMS.Version do
  use MMS.Either, [MMS.VersionInteger, MMS.Text]
end
