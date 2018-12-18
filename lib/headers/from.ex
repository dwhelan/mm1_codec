defmodule MMS.From do
  import MMS.OkError

  alias MMS.{Length, Byte, Short, Mapper, Long, EncodedString}

  @decode_map %{0 => :absolute, 1 => :relative}
  @encode_map MMS.Mapper.reverse @decode_map

  @address_present_token 128
  @insert_address_token  129

  def decode bytes do
    with {:ok, {length,   absolute_bytes}} <- Length.decode(bytes),
         {:ok, {absolute, value_bytes   }} <- Byte.decode(absolute_bytes)
    do
      decode(value_bytes, absolute)
    else
      error -> error
    end
  end

  defp decode bytes, @address_present_token do
    EncodedString.decode bytes
  end

  defp decode _, @insert_address_token do
    {:ok, :insert_address}
  end

  defp decode _, absolute do
    {:error, {:address_token_must_be_128_to_129, absolute}}
  end

  def encode string do
    with {:ok, string_bytes} <- EncodedString.encode(string),
         {:ok, length_bytes} <- Length.encode(1 + byte_size(string_bytes))
    do
      ok length_bytes <> <<@address_present_token>> <> string_bytes
    else
      error -> error
    end
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
