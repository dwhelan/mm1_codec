defmodule MMS.ValueLengthComposer do
  use MMS.Codec2

  alias MMS.{Composer2, ValueLength}

  def decode bytes, functions do
    bytes
    |> ValueLength.decode
    ~> fn result -> decode_values result, functions, bytes end
  end

  defp decode_values {length, value_bytes}, functions, bytes do
    value_bytes
    |> Composer2.decode(functions)
    ~>> fn values -> length_details(length, bytes, values, value_bytes) end
    ~> fn {values, rest} -> check_value_bytes_used(length, value_bytes, values, rest, bytes) end
  end

  defp length_details length, bytes, values, value_bytes do
    length_bytes_used = byte_size(bytes) - byte_size(value_bytes)
    length_bytes = binary_part(bytes, 0, length_bytes_used)
    %{length: {length, length_bytes}, values: values}
  end

  defp check_value_bytes_used(length, value_bytes, values, rest, _bytes) when length == byte_size(value_bytes) - byte_size(rest) do
    ok values, rest
  end

  defp check_value_bytes_used(length, value_bytes, values, rest, bytes) do
    bytes_used = byte_size(value_bytes) - byte_size(rest)
    error_details = length_details(length, bytes, values, value_bytes) |> Map.put(:bytes_used, bytes_used)
    error :incorrect_value_length, bytes, error_details
  end

  def encode values, functions do
    values
    |> Composer2.encode(functions)
    ~> fn bytes ->
         case bytes |> byte_size |> ValueLength.encode do
           {:ok, length_bytes} -> ok length_bytes <> bytes
           error        -> error
         end
         <<byte_size(bytes)>> <> bytes
       end
  end
end

defmodule MMS.Composer2 do
  use MMS.Codec2

  def decode bytes, functions do
    bytes
    |> do_decode(functions, [])
  end

  defp do_decode rest, [], values do
    ok Enum.reverse(values), rest
  end

  defp do_decode rest, [f | functions], values do
    case rest |> f.() do
      {:ok, {value, rest}} -> do_decode rest, functions, [value | values]
      error                -> [error | values] |> Enum.reverse |> error
    end
  end

  def encode [], _  do
    ok <<>>
  end

  def encode values, functions do
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
