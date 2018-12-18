defmodule MMS.Seconds do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.{Length, Byte, Long}

  @absolute 128
  @relative 129

  def decode bytes do
    with {:ok, {length,   absolute_bytes}} <- Length.decode(bytes),
         {:ok, {absolute, value_bytes   }} <- Byte.decode(absolute_bytes),
         {:ok, {seconds,  rest          }} <- Long.decode(value_bytes),
         :ok                               <- check_length(length, absolute_bytes, rest),
         :ok                               <- check_absolute(absolute)
    do
      ok value(seconds, absolute), rest
    else
      error -> error
    end
  end

  defp check_length(length, data_bytes, rest) when length == byte_size(data_bytes) - byte_size(rest) do
    :ok
  end

  defp check_length _, _, _  do
    {:error, :incorrect_length}
  end

  defp check_absolute(absolute) when absolute in [@absolute, @relative]   do
    :ok
  end

  defp check_absolute absolute do
    {:error, {:absolute_value_must_be_128_to_129, absolute}}
  end

  defp value seconds, @absolute do
    DateTime.from_unix! seconds
  end

  defp value seconds, @relative do
    seconds
  end

  def encode %DateTime{} = date_time do
    encode DateTime.to_unix(date_time), @absolute
  end

  def encode(value) when is_long_integer(value) do
    encode value, @relative
  end

  def encode value do
    Long.encode value
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