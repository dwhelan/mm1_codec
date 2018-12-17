defmodule MMS.Seconds do
  import MMS.OkError

  alias MMS.{Length, Short, Mapper, LongInteger}

  @map         %{0 => :absolute, 1 => :relative}
  @reverse_map %{absolute: 0,    relative: 1   }

  def decode bytes do
    with {:ok, {length,   absolute_bytes}} <- Length.decode(bytes),
         {:ok, {absolute, value_bytes   }} <- Mapper.decode(absolute_bytes, Short, @map),
         {:ok, {value,    rest          }} <- LongInteger.decode(value_bytes)
    do
      ok {value, absolute, length}, rest
    else
      error -> error
    end
  end

  def encode {value, absolute, length} do
    with {:ok, length_bytes} <- Length.encode(length),
         {:ok, data_bytes  } <- encode(value, absolute)
    do
      ok length_bytes <> data_bytes
    else
      error -> error
    end
  end

  def encode {value, absolute} do
    with {:ok, data_bytes} <- encode value, absolute
    do
      ok <<byte_size(data_bytes)>> <> data_bytes
    else
      error -> error
    end
  end

  def encode %DateTime{} = date_time do
    encode {DateTime.to_unix(date_time), :absolute}
  end

  def encode value do
    encode {value, :absolute}
  end

  defp encode value, absolute do
    with {:ok, absolute_bytes} <- Mapper.encode(absolute, Short, @reverse_map),
         {:ok, value_bytes   } <- LongInteger.encode(value)
    do
      ok absolute_bytes <> value_bytes
    else
      error -> error
    end
  end
end
