defmodule MMS.ValueLengthComposer do
  use MMS.Codec2

  alias MMS.{Composer2, ValueLength}

  def decode bytes, fs do
    bytes
    |> Composer2.decode([&ValueLength.decode/1 | fs])
    ~> fn result -> check_bytes_used(result, bytes) end
  end

  defp check_bytes_used({result = [length | values], rest}, bytes) when length == (byte_size(bytes) - byte_size(rest) - 1) do
    ok result, rest
  end

  defp check_bytes_used {[length | values], rest}, bytes do
    error [error({:incorrect_value_length, length, [bytes_actually_used: byte_size(bytes) - byte_size(rest) - 1]}) | values]
  end
end

defmodule MMS.Composer2 do
  use MMS.Codec2

  def decode bytes, fs do
    bytes
    |> do_decode(fs, [])
    ~>> fn results -> error Enum.reverse(results) end
  end

  defp do_decode bytes, [], values do
    ok Enum.reverse(values), bytes
  end

  defp do_decode bytes, [f | fs], values do
    case bytes |> f.() do
      {:ok, {value, rest}} -> do_decode rest, fs, [value | values]
      error                -> error [error | values]
    end
  end

  def encode [], _  do
    ok <<>>
  end

  def encode values, fs do
    do_encode(Enum.zip(values, fs), [])
    ~>> fn results -> error Enum.reverse(results) end
  end

  defp do_encode [], value_bytes do
    ok value_bytes |> Enum.reverse |> Enum.join
  end

  defp do_encode [{value, f} | list], value_bytes do
    case value |> f.() do
      {:ok, bytes} -> do_encode list, [bytes | value_bytes]
      error        -> error [error | value_bytes]
    end
  end
end
