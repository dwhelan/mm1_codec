defmodule MMS.List do
  use MMS.Codec2

  def decode_with(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> do_decode_with(codecs, [])
    ~>> fn error -> decode_error bytes, error end
  end

  defp do_decode_with bytes, [codec | codecs], values do
    bytes
    |> codec.decode
    ~>> fn error         -> error %{error: error, values: Enum.reverse(values)} end
    ~>  fn {value, rest} -> do_decode_with rest, codecs, [value | values] end
  end

  defp do_decode_with rest, [], values do
    ok Enum.reverse(values), rest
  end

#  def decode(bytes, functions) when is_binary(bytes) and is_list(functions) do
#    bytes
#    |> do_decode(functions, [])
#    ~>> fn error -> decode_error bytes, error end
#  end
#
#  defp do_decode bytes, [f | functions], values do
#    bytes
#    |> f.()
#    ~>> fn error         -> error %{error: error, values: Enum.reverse(values)} end
#    ~>  fn {value, rest} -> do_decode rest, functions, [value | values] end
#  end
#
#  defp do_decode rest, [], values do
#    ok Enum.reverse(values), rest
#  end

  def encode2 [], _  do
    ok <<>>
  end

  def encode2(values, codecs) when is_list(values) and is_list(codecs) do
    values
    |> Enum.zip(codecs)
    |> do_encode2([])
    ~>> fn error -> error error_name(), values, error end
  end

  defp do_encode2 [], bytes_list do
    bytes_list
    |> Enum.reverse
    |> Enum.join
    |> ok
  end

  defp do_encode2 [{value, codec} | value_pairs], bytes_list do
    value
    |> codec.encode
    ~>  fn bytes -> do_encode2 value_pairs, [bytes | bytes_list] end
  end

#  def encode(values, functions) when is_list(values) and is_list(functions) do
#    values
#    |> Enum.zip(functions)
#    |> do_encode([])
#    ~>> fn error -> error error_name(), values, error end
#  end
#
#  defp do_encode [], bytes_list do
#    bytes_list
#    |> Enum.reverse
#    |> Enum.join
#    |> ok
#  end
#
#  defp do_encode [{value, f} | value_pairs], bytes_list do
#    value
#    |> f.()
#    ~>  fn bytes -> do_encode value_pairs, [bytes | bytes_list] end
#  end
end
