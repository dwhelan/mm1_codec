defmodule MMS.ValueLengthComposer do
  use MMS.Codec2

  alias MMS.{Composer2, ValueLength}

  def decode bytes, functions do
    bytes
    |> Composer2.decode([&ValueLength.decode/1 | functions])
    ~> fn result -> check_bytes_used(result, bytes) end
  end

  defp check_bytes_used({result = [length | values], rest}, bytes) do
    used = byte_size(bytes) - byte_size(rest) - 1
    if used == length do
      ok result, rest
    else
      error [error({:incorrect_value_length, length, [bytes_actually_used: used]}) | values]
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
