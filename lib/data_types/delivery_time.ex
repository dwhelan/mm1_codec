defmodule MMS.DeliveryTime do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.{Length, LongInteger, ShortInteger}

  def decode bytes do
    with {:ok, {length,   absolute_bytes}} <- Length.decode(bytes),
         {:ok, {absolute, value_bytes   }} <- ShortInteger.decode(absolute_bytes),
         {:ok, {value,    rest          }} <- LongInteger.decode(value_bytes)
    do
      ok {value, :absolute, length}, rest
    else
      error -> error
    end
  end

  def encode {value, :absolute, length} do
    with {:ok, length_bytes } <- Length.encode(length),
         {:ok, value_bytes } <- LongInteger.encode(value)
    do
      ok length_bytes <> <<128>> <> value_bytes
    else
      error -> error
    end
  end

  def encode string do
    string |> String.encode
  end
end
