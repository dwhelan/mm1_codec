defmodule MMS.List do
  use MMS.Codec2

  def decode(bytes, functions) when is_binary(bytes) and is_list(functions) do
    bytes
    |> do_decode(functions, [])
    ~>> fn error -> decode_error bytes, error end
  end

  defp do_decode bytes, [f | functions], values do
    bytes
    |> f.()
    ~>> fn error         -> error %{error: error, values: Enum.reverse(values)} end
    ~>  fn {value, rest} -> do_decode rest, functions, [value | values] end
  end

  defp do_decode rest, [], values do
    ok Enum.reverse(values), rest
  end

  def encode [], _  do
    ok <<>>
  end

  def encode(values, functions) when is_list(values) and is_list(functions) do
    values
    |> Enum.zip(functions)
    |> do_encode([])
    ~>> fn error -> error error_name(), values, error end
  end

  defp do_encode [], bytes_list do
    bytes_list
    |> Enum.reverse
    |> Enum.join
    |> ok
  end

  defp do_encode [{value, f} | value_pairs], bytes_list do
    value
    |> f.()
    ~>  fn bytes -> do_encode value_pairs, [bytes | bytes_list] end
  end
end
