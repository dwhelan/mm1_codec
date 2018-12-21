defmodule MMS.ContentType do
  alias MMS.{Composer, Media}

  import MMS.OkError
  import MMS.DataTypes

  def decode(<<byte, _::binary>> = bytes) when is_short_length(byte) do
    case_ok Composer.decode bytes, {Media} do
      {{media}, rest} -> ok {media, []}, rest
    end
  end

  def decode bytes do
    Media.decode bytes
  end

  def encode {media, _parameters} do
    Composer.encode {media}, {Media}
  end

  def encode value do
    Media.encode value
  end
end
