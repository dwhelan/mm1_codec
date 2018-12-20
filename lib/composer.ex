defmodule MMS.Composer do
  import MMS.OkError

  alias MMS.Length

  def decode bytes, codecs do
    case_ok Length.decode bytes do
      {length, rest} -> do_decode rest, Tuple.to_list(codecs), [], length
    end
  end

  defp do_decode rest, _, values, 0 do
    return values, rest
  end

  defp do_decode(_, _, _, length) when length < 0 do
    error :incorrect_length
  end

  defp do_decode(_, [], _, length) when length > 0 do
    error :incorrect_length
  end

  defp do_decode bytes, [codec | codecs], values, length do
    case_ok codec.decode bytes do
      {value, rest} -> do_decode rest, codecs, [value | values], remaining(length, bytes, rest)
    end
  end

  defp return values, rest do
    ok values |> Enum.reverse |> List.to_tuple, rest
  end

  defp remaining length, bytes, rest do
    length - byte_size(bytes) + byte_size(rest)
  end

  def encode(values, codecs) when is_tuple(values) and tuple_size(values) > 0 and is_tuple(codecs) and tuple_size(codecs) > 0 do
    do_encode zip(values, codecs), []
  end

  def encode _, _ do
    error :must_provide_at_least_one_value_and_codec
  end

  defp zip values, codecs do
    Enum.zip Tuple.to_list(values), Tuple.to_list(codecs)
  end

  defp do_encode [{value, codec} | tuples], value_bytes do
    case_ok codec.encode value do
      bytes -> do_encode tuples, [bytes | value_bytes]
    end
  end

  defp do_encode [], value_bytes do
    bytes = value_bytes |> Enum.reverse |> Enum.join

    case_ok bytes |> byte_size |> Length.encode do
      length_bytes -> ok length_bytes <> bytes
    end
  end
end
