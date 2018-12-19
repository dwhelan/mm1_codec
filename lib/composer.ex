defmodule MMS.Composer do
  import MMS.OkError

  def decode bytes, codecs do
    decode bytes, codecs, []
  end

  defp decode bytes, [codec | codecs], values do
    case codec.decode bytes do
      {:ok,    {value, rest}} -> decode rest, codecs, [value | values]
      {:error, reason       } -> error codec, reason
    end
  end

  defp decode rest, [], values do
    ok Enum.reverse(values), rest
  end
end
