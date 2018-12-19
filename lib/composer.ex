defmodule MMS.Composer do
  import MMS.OkError

  alias MMS.Length

  def decode bytes, codecs do
    codecs = Tuple.to_list codecs

    with {:ok, {length, data_bytes}} <- Length.decode(bytes),
         {:ok, {values, rest      }} <- do_decode(data_bytes, codecs, []),
         :ok                         <- check(length, data_bytes, rest)
    do
      ok values, rest
    else
      error -> error
    end
  end

  defp do_decode bytes, [codec | codecs], values do
    case codec.decode bytes do
      {:ok, {value, rest}} -> decode rest, codecs, [value | values]
      error                -> error
    end
  end

  defp do_decode rest, [], values do
    ok values |> Enum.reverse |> List.to_tuple, rest
  end

  defp check(length, bytes, rest) when length == byte_size(bytes) - byte_size(rest) do
    :ok
  end

  defp check _, _, _  do
    {:error, :incorrect_length}
  end

  def encode values, codecs do
    do_encode Enum.zip(Tuple.to_list(values), Tuple.to_list(codecs)), []
  end

  defp do_encode [{value, codec} | tuples], bytes_list do
    case codec.encode value do
      {:ok, bytes} -> encode tuples, [bytes | bytes_list]
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
