defmodule MMS.Seconds do
  import MMS.OkError

  alias MMS.{Composer, Length, Byte, Long}

  @absolute 128
  @relative 129

  def decode bytes do
    case Composer.decode bytes, [Byte, Long] do
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

  defp evaluate {{absolute, _}, _} do
    error {:absolute_value_must_be_128_to_129, absolute}
  end

  def encode %DateTime{} = date_time do
    encode DateTime.to_unix(date_time), @absolute
  end

  def encode value do
    encode value, @relative
  end

  defp encode value, absolute do
    with {:ok, absolute_bytes} <- Byte.encode(absolute),
         {:ok, value_bytes   } <- Long.encode(value),
         {:ok, length_bytes  } <- Length.encode(1 + byte_size(value_bytes))
    do
      ok length_bytes <> absolute_bytes <> value_bytes
    else
      error -> error
    end
  end
end

