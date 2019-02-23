defmodule MMS.List do
  use MMS.Codec2

  def decode(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> do_decode(codecs, [])
    ~>> fn error -> decode_error bytes, error end
  end

  defp do_decode bytes, [codec | codecs], values do
    bytes
    |> codec.decode
    ~>> fn details         -> error %{error: details, values: Enum.reverse(values)} end
    ~>  fn {value, rest} -> do_decode rest, codecs, [value | values] end
  end

  defp do_decode rest, [], values do
    ok Enum.reverse(values), rest
  end

  def encode [], _  do
    ok <<>>
  end

  def encode(values, codecs) when is_list(values) and is_list(codecs) do
    values
    |> Enum.zip(codecs)
    |> do_encode([])
    ~>> fn details -> error data_type(), values, details end
  end

  defp do_encode [], bytes_list do
    bytes_list
    |> Enum.reverse
    |> Enum.join
    |> ok
  end

  defp do_encode [{value, codec} | value_pairs], bytes_list do
    value
    |> codec.encode
    ~>  fn bytes -> do_encode value_pairs, [bytes | bytes_list] end
  end
end
