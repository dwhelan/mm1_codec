defmodule MMS.Media do
  use MMS.Codec2

  alias MMS.{Text, WellKnownMedia}

  def decode(<<char, _::binary>> = bytes) when is_text(char) do
    bytes
    |> do_decode(Text)
  end

  def decode bytes do
    bytes
    |> do_decode(WellKnownMedia)
  end

  defp do_decode bytes, codec do
    bytes
    |> codec.decode
    ~>> fn details -> decode_error bytes, details end
  end

  def encode(string) when is_binary(string) do
    string
    |> WellKnownMedia.encode
    ~>> fn _ -> string |> Text.encode end
    ~>> fn details -> error string, details end
  end
end
