defmodule MMS.List do
  use MMS.Codec

  def decode(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> do_decode(codecs, [])
    ~>> & error bytes, &1
  end

  defp do_decode bytes, [codec | codecs], values do
    bytes
    |> codec.decode
    ~>> fn details -> error %{error: details, values: Enum.reverse(values)} end
    ~> fn {value, rest} ->
      rest
      |> do_decode(codecs, [value | values]) end
  end

  defp do_decode rest, [], values do
    values
    |> Enum.reverse
    |> ok(rest)
  end

  def encode(values, codecs) when is_list(values) and is_list(codecs) do
    values
    |> Enum.zip(codecs)
    |> do_encode([])
    ~>> fn details -> error datxa_type(), values, details end
  end

  defp do_encode [], bytes_list do
    ok Enum.join bytes_list
  end

  defp do_encode [{value, codec} | values], bytes_list do
    value
    |> codec.encode
    ~> fn bytes -> do_encode(values, bytes_list ++ [bytes]) end
  end
end
