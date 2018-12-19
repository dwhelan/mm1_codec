defmodule MMS.Composer do
  import MMS.OkError

  alias MMS.Length

  def decode bytes, codecs do
    codecs = Tuple.to_list codecs

    with {:ok, {length, data_bytes}} <- Length.decode(bytes),
         {:ok, {values, rest      }} <- do_decode(data_bytes, codecs, [], length)
    do
      ok values, rest
    else
      error -> error
    end
  end

#  defp do_decode <<>>, _, [], length do
#    error :insufficient_bytes
#  end

  defp do_decode rest, _, values, 0 do
    return values, rest
  end

  defp do_decode(_, _, _, length) when length < 0 do
    error :incorrect_length
  end

  defp do_decode(rest, [], values, length) when length > 0 do
    error :incorrect_length
  end

  defp do_decode bytes, [codec | codecs], values, length do
    case codec.decode bytes do
      {:ok, {value, rest}} -> do_decode rest, codecs, [value | values], remaining(length, bytes, rest)
      error                -> error
    end
  end

  defp return values, rest do
    ok values |> Enum.reverse |> List.to_tuple, rest
  end

  defp remaining length, bytes, rest do
    length - byte_size(bytes) + byte_size(rest)
  end

  def encode values, codecs do
    values = Tuple.to_list values
    codecs = Tuple.to_list codecs
    do_encode Enum.zip(values, codecs), []
  end

  defp do_encode [{value, codec} | tuples], bytes_list do
    case codec.encode value do
      {:ok, bytes} -> do_encode tuples, [bytes | bytes_list]
      error        -> error
    end
  end

  defp do_encode [], bytes_list do
    data_bytes = bytes_list |> Enum.reverse |> Enum.join

    case data_bytes |> byte_size |> Length.encode do
      {:ok, length_bytes} -> ok length_bytes <> data_bytes
      error -> error
    end
  end
end
