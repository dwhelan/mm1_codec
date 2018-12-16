defmodule MMS.DeliveryTime do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.{Length, LongInteger, ShortInteger, Mapper}

  def decode bytes do
    with {:ok, {length,   absolute_bytes}} <- Length.decode(bytes),
         {:ok, {absolute, value_bytes   }} <- Mapper.decode(absolute_bytes, ShortInteger, %{0 => :absolute, 1 => :relative}),
         {:ok, {value,    rest          }} <- LongInteger.decode(value_bytes)
    do
      ok {value, absolute, length}, rest
    else
      error -> error
    end
  end

  def encode {value, absolute, length} do
    with {:ok, length_bytes  } <- Length.encode(length),
         {:ok, absolute_bytes} <- Mapper.encode(absolute, ShortInteger, %{absolute: 0, relative: 1}),
         {:ok, value_bytes   } <- LongInteger.encode(value)
    do
      ok length_bytes <> absolute_bytes <> value_bytes
    else
      error -> error
    end
  end

  def encode string do
    string |> String.encode
  end
end
