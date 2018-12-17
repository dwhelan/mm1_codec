defmodule MMS.DateTime do
  import MMS.OkError

  alias MMS.{Length, ShortInteger, Mapper, LongInteger}

  @map %{0 => :absolute, 1 => :relative}

  def decode bytes do
    with {:ok, {length,   absolute_bytes}} <- Length.decode(bytes),
         {:ok, {absolute, value_bytes   }} <- Mapper.decode(absolute_bytes, ShortInteger, @map),
         {:ok, {value,    rest          }} <- LongInteger.decode(value_bytes)
    do
      ok {value, absolute, length}, rest
    else
      error -> error
    end
  end

  @reverse_map @map |> MMS.Mapper.reverse

  def encode {value, absolute, length} do
    with {:ok, length_bytes  } <- Length.encode(length),
         {:ok, absolute_bytes} <- Mapper.encode(absolute, ShortInteger, @reverse_map),
         {:ok, value_bytes   } <- LongInteger.encode(value)
    do
      ok length_bytes <> absolute_bytes <> value_bytes
    else
      error -> error
    end
  end

  def encode {value, absolute} do
    with {:ok, absolute_bytes} <- Mapper.encode(absolute, ShortInteger, @reverse_map),
         {:ok, value_bytes   } <- LongInteger.encode(value)
    do
      length = byte_size(absolute_bytes) + byte_size(value_bytes)
      ok <<length>> <> absolute_bytes <> value_bytes
    else
      error -> error
    end
  end
end
