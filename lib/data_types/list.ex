defmodule MMS.List do
  use MMS.Codec2

  def decode(bytes, functions) when is_binary(bytes) and is_list(functions) do
    bytes
    |> do_decode(functions, [])
  end

  defp do_decode rest, [f | functions], values do
    case rest |> f.() do
      {:ok, {value, rest}} -> do_decode rest, functions, [value | values]
      error                -> [error | values] |> Enum.reverse |> error
    end
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
  end

  defp do_encode [], bytes_list do
    ok bytes_list |> Enum.reverse |> Enum.join
  end

  defp do_encode [{value, f} | value_pairs], bytes_list do
    case value |> f.() do
      {:ok, bytes} -> do_encode value_pairs, [bytes | bytes_list]
      error        -> [error | bytes_list] |> Enum.reverse |> error
    end
  end
end
