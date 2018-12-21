defmodule MMS.ContentType do
  alias MMS.{Media, String}

  import MMS.OkError
  import MMS.DataTypes

  def decode(<<byte, _::binary>> = bytes) when is_short_length(byte) == false do
    Media.decode bytes
  end

#  def decode bytes do
#    String.decode bytes
#  end

  def encode value do
    case_error Media.encode value do
      _ -> String.encode value
    end
  end
end
