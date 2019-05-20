defmodule MMS.ValueLengthList do
  use MMS.Codec

  alias MMS.{List, ValueLength}

  def decode(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> ValueLength.decode
    ~> fn {length, value_bytes} ->
         value_bytes
         |> List.decode(codecs)
         ~>> fn {data_type, _, details} -> error bytes, [data_type, Map.merge(details, %{length: length})] end
         ~> fn {values, rest} -> ensure_correct_length(length, value_bytes, values, rest, bytes) end
       end
  end

  defp ensure_correct_length(length, value_bytes, values, rest, _bytes) when length == byte_size(value_bytes) - byte_size(rest) do
    values |> ok(rest)
  end

  defp ensure_correct_length(length, value_bytes, values, rest, bytes) do
    bytes |> error(%{length: length, bytes_used: byte_size(value_bytes) - byte_size(rest), values: values})
  end

  def encode(values, codecs) when is_list(values) and is_list(codecs) do
    values
    |> List.encode(codecs)
    ~> fn value_bytes ->
         value_bytes
         |> byte_size
         |> ValueLength.encode
         ~> & &1 <> value_bytes
       end
  end
end
