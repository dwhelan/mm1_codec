defmodule MMS.Media do
  alias MMS.{WellKnownMedia, String, Short, Long}

  import MMS.OkError
  import MMS.DataTypes

  def decode(<<byte, _::binary>> = bytes) when is_short_byte(byte) do
    WellKnownMedia.decode bytes
  end

  def decode bytes do
    String.decode bytes
  end

  def encode value do
    case WellKnownMedia.encode value do
      {:error, _} -> String.encode value
      ok -> ok
    end
  end
end
