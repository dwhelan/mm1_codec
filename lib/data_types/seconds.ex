defmodule MMS.Seconds do
  import MMS.OkError

  alias MMS.{Composer, Byte, Long}

  @absolute 128
  @relative 129
  @codecs   [Byte, Long]

  def decode bytes do
    case_ok Composer.decode bytes, @codecs do
      {{seconds, absolute}, rest} -> evaluate absolute, seconds, rest
    end
  end

  defp evaluate @absolute, seconds, rest do
    ok DateTime.from_unix!(seconds), rest
  end

  defp evaluate @relative, seconds, rest do
    ok seconds, rest
  end

  defp evaluate _, _, _ do
    error :invalid_absolute_relative_token
  end

  def encode %DateTime{} = date_time do
    encode @absolute, DateTime.to_unix(date_time)
  end

  def encode value do
    encode @relative, value
  end

  defp encode absolute, value do
    Composer.encode [absolute, value], @codecs
  end
end
