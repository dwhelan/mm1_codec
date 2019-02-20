defmodule MMS.ValueLengthList do
  use MMS.Codec2

  alias MMS.{List, ValueLength}

  def decode(bytes, functions) when is_binary(bytes) and is_list(functions) do
    bytes
    |> ValueLength.decode
    ~> fn result -> result |> do_decode(functions, bytes) end
  end

  defp do_decode {length, value_bytes}, functions, bytes do
    value_bytes
    |> List.decode(functions)
    ~>> fn {data_type, _, details} -> error bytes, [data_type, Map.merge(details, %{length: length})] end
    ~> fn {values, rest} -> ensure_correct_length(length, value_bytes, values, rest, bytes) end
  end

  defp ensure_correct_length(length, value_bytes, values, rest, _bytes) when length == byte_size(value_bytes) - byte_size(rest) do
    ok values, rest
  end

  defp ensure_correct_length(length, value_bytes, values, rest, bytes) do
    bytes_used = byte_size(value_bytes) - byte_size(rest)
    error bytes, %{length: length, bytes_used: bytes_used, values: values}
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
