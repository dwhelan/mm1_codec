defmodule MMS.Seconds do
  import MMS.OkError

  alias MMS.{Composer, Byte, Long}

  @absolute 128
  @relative 129

  def decode bytes do
    case Composer.decode bytes, {Byte, Long} do
      {:ok, results} -> evaluate results
      error          -> error
    end
  end

  defp evaluate {{@absolute, seconds}, rest} do
    ok DateTime.from_unix!(seconds), rest
  end

  defp evaluate {{@relative, seconds}, rest} do
    ok seconds, rest
  end

  defp evaluate _ do
    error :absolute_value_must_be_128_to_129
  end

  def encode %DateTime{} = date_time do
    encode @absolute, DateTime.to_unix(date_time)
  end

  def encode value do
    encode @relative, value
  end

  defp encode absolute, value do
    Composer.encode {absolute, value}, {Byte, Long}
  end
end

