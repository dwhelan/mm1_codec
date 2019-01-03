defmodule MMS.ContentType do
  use MMS.Codec
  alias MMS.{Composer, Media}

  def decode(<<byte, _::binary>> = bytes) when is_short_length(byte) do
    case_ok Composer.decode bytes, [Media] do
      {{media}, rest} -> ok {media, []}, rest
    end
  end

  def decode bytes do
    bytes |> Media.decode
  end

  def encode {media, _parameters} do
    Composer.encode [media], [Media]
  end

  def encode value do
    value |> Media.encode
  end
end
