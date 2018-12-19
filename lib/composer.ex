defmodule MMS.Composer do
  import MMS.OkError

  def decode bytes, codecs do
    with {:ok, {length, data_bytes}} <- MMS.Length.decode(bytes),
         {:ok, {values, rest      }} <- decode(data_bytes, codecs, []),
         :ok                         <- check(length, data_bytes, rest)
    do
      ok values, rest
    else
      error -> error
    end
  end

  defp decode bytes, [codec | codecs], values do
    case codec.decode bytes do
      {:ok, {value, rest}} -> decode rest, codecs, [value | values]
      error                -> error
    end
  end

  defp decode rest, [], values do
    ok values |> Enum.reverse |> List.to_tuple, rest
  end

  defp check(length, bytes, rest) when length == byte_size(bytes) - byte_size(rest) do
    :ok
  end

  defp check _, _, _  do
    {:error, :incorrect_length}
  end
end
