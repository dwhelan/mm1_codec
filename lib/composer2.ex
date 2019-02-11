defmodule MMS.ValueLengthComposer do
  use MMS.Codec2

  alias MMS.{Composer2, ValueLength}

  def decode bytes, functions do
    bytes
    |> ValueLength.decode
    ~> fn result -> decode_values result, functions end
  end

  defp decode_values {length, value_bytes}, functions do
    value_bytes
    |> Composer2.decode(functions)
    ~>> fn results -> [length | results] end
    ~> fn {values, rest} -> check_value_bytes_used(length, used(value_bytes, rest), values, rest) end
  end

  defp used value_bytes, rest do
    byte_size(value_bytes) - byte_size(rest)
  end

  defp check_value_bytes_used(length, used, values, rest) when length == used do
    ok [length | values], rest
  end

  defp check_value_bytes_used(length, used, values, _rest) do
    error [incorrect_value_length(length, used) | values]
  end

  defp incorrect_value_length length, used do
    error :incorrect_value_length, length, [bytes_actually_used: used]
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
