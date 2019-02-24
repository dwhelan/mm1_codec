defmodule MMS.VersionInteger do
  use MMS.Codec2

  @major_range 0..7
  @minor_range 0..14
  @no_minor    15

  def decode <<1::1, major::3, @no_minor::4, rest::binary>> do
    major |> decode_ok(rest)
  end

  def decode <<1::1, major::3, minor::4, rest::binary>> do
    {major, minor} |> decode_ok(rest)
  end

  def decode bytes = <<version, _::binary>> do
    bytes |> decode_error(%{out_of_range: version})
  end

  def encode(major) when major in @major_range do
    {major, @no_minor} |> do_encode
  end

  def encode(major) when is_integer(major) do
    major |> encode_error(:out_of_range)
  end

  def encode({major, minor}) when major in @major_range and minor in @minor_range do
    {major, minor} |> do_encode
  end

  def encode({major, minor}) when is_integer(major) and minor in @minor_range do
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
  use MMS.Codec2

  alias MMS.{VersionInteger, Text}

  def decode(bytes = <<char, _::binary>>) when is_char(char) do
    bytes |> decode_with(Text)
  end

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_with(VersionInteger)
  end

  def encode(string) when is_binary(string) do
    string |> encode_with(Text)
  end

  def encode(value) do
    value |> encode_with(VersionInteger)
  end
end
