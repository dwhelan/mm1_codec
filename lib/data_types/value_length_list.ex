defmodule MMS.ValueLengthList do
  use MMS.Codec2

  alias MMS.{List, ValueLength}

  def decode(bytes, functions) when is_binary(bytes) and is_list(functions) do
    bytes
    |> ValueLength.decode
    ~> fn result -> result |> decode_values(functions, bytes) end
  end

  defp decode_values {length, value_bytes}, functions, bytes do
    value_bytes
    |> List.decode(functions)
    ~>> fn values -> length_details(length, bytes, values, value_bytes) end
    ~> fn {values, rest} -> check_value_bytes_used(length, value_bytes, values, rest, bytes) end
  end

  defp length_details length, bytes, values, value_bytes do
    length_bytes_used = byte_size(bytes) - byte_size(value_bytes)
    length_bytes      = binary_part(bytes, 0, length_bytes_used)
    %{length: {length, length_bytes}, values: values}
  end

  defp check_value_bytes_used(length, value_bytes, values, rest, _bytes) when length == byte_size(value_bytes) - byte_size(rest) do
    ok values, rest
  end

  defp check_value_bytes_used(length, value_bytes, values, rest, bytes) do
    bytes_used    = byte_size(value_bytes) - byte_size(rest)
    error_details = length_details(length, bytes, values, value_bytes) |> Map.put(:bytes_used, bytes_used)
    error :incorrect_value_length, bytes, error_details
  end

  def encode(values, functions) when is_list(values) and is_list(functions) do
    values
    |> List.encode(functions)
    ~> fn value_bytes ->
         value_bytes
         |> byte_size
         |> ValueLength.encode
         ~> fn length_bytes -> ok length_bytes <> value_bytes end
       end
  end
end
