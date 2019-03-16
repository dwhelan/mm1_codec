defmodule MMS.Tuple do
  use MMS.Codec

  def decode(bytes, codecs) when is_binary(bytes) and is_tuple(codecs) do
    bytes
    |> MMS.List.decode(Tuple.to_list codecs)
    ~> fn {values, rest} -> decode_ok List.to_tuple(values), rest end
  end
end

defmodule MMS.List do
  use MMS.Codec

  def decode(bytes, codecs) when is_binary(bytes) and is_tuple(codecs) do
    bytes
    |> decode(Tuple.to_list codecs)
    ~> fn {values, rest} -> decode_ok List.to_tuple(values), rest end
  end

  def decode(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> do_decode(codecs, [])
    ~>> & bytes |> decode_error(&1)
  end

  defp do_decode bytes, [codec | codecs], values do
    bytes
    |> codec.decode
    ~>> fn details       -> error %{error: details, values: Enum.reverse(values)} end
    ~>  fn {value, rest} -> rest |> do_decode(codecs, [value | values]) end
  end

  defp do_decode rest, [], values do
    values |> Enum.reverse |> decode_ok(rest)
  end

  def encode [], _  do
    ok <<>>
  end

  def encode(values, codecs) when is_tuple(values) and is_tuple(codecs) do
    values
    |> Tuple.to_list
    |> Enum.zip(Tuple.to_list codecs)
    |> do_encode([])
    ~>> fn details -> error data_type(), values, details end
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
    ~> fn bytes -> value_pairs |> do_encode([bytes | bytes_list]) end
  end
end
