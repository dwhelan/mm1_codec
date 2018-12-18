defmodule MMS.From do
  import MMS.OkError

  alias MMS.{Length, Short, Mapper, Long}

  @decode_map %{0 => :absolute, 1 => :relative}
  @encode_map MMS.Mapper.reverse @decode_map

  def decode bytes do
    with {:ok, {length,   absolute_bytes}} <- Length.decode(bytes),
         {:ok, {absolute, value_bytes   }} <- Mapper.decode(absolute_bytes, Short, @decode_map),
         {:ok, {seconds,  rest          }} <- Long.decode(value_bytes)
    do
      ok {value(seconds, absolute), length}, rest
    else
      error -> error
    end
  end

  defp value seconds, :absolute do
    DateTime.from_unix! seconds
  end

  defp value seconds, :relative do
    seconds
  end

  def encode %DateTime{} = date_time do
    encode DateTime.to_unix(date_time), :absolute
  end

  def encode {%DateTime{} = date_time, length} do
    encode DateTime.to_unix(date_time), :absolute, length
  end

  def encode(value) when is_integer(value) do
    encode value, :relative
  end

  def encode({value, length}) when is_integer(value) do
    encode value, :relative, length
  end

  defp encode value, absolute, length do
    with {:ok, length_bytes} <- Length.encode(length),
         {:ok, data_bytes  } <- encode_data(value, absolute)
      do
      ok length_bytes <> data_bytes
    else
      error -> error
    end
  end

  defp encode value, absolute do
    with {:ok, data_bytes} <- encode_data value, absolute
    do
      ok <<byte_size(data_bytes)>> <> data_bytes
    else
      error -> error
    end
  end

  defp encode_data value, absolute do
    with {:ok, absolute_bytes} <- Mapper.encode(absolute, Short, @encode_map),
         {:ok, value_bytes   } <- Long.encode(value)
    do
      ok absolute_bytes <> value_bytes
    else
      error -> error
    end
  end
end
