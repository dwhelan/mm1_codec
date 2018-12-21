defmodule MMS.Media do
  alias MMS.{WellKnownMedia, Short, Long}

  import MMS.OkError
  import MMS.DataTypes

  def decode(<<byte, _::binary>> = bytes) when is_short(byte) do
    WellKnownMedia.decode bytes
  end

#  def decode(<<byte, _::binary>> = bytes) when is_long_byte(byte) do
#    Long.decode bytes
#  end
#
#  def decode _ do
#    error :invalid_integer
#  end

  def encode(value) do
    WellKnownMedia.encode value
  end

#  def encode(value) when is_long(value) do
#    Long.encode value
#  end
#
#  def encode _ do
#    error :invalid_integer
#  end
end
