defmodule MMS.Media do
  alias MMS.{WellKnownMedia, String}

  import MMS.OkError
  import MMS.DataTypes

  def decode(<<byte, _::binary>> = bytes) when is_short_byte(byte) do
    WellKnownMedia.decode bytes
  end

  def decode bytes do
    String.decode bytes
  end

  def encode value do
    case_error WellKnownMedia.encode value do
      _ -> String.encode value
    end
  end
end