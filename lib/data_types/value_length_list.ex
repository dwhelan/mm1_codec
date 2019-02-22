defmodule MMS.ValueLengthList do
  use MMS.Codec2

  alias MMS.{List, ValueLength}

  def decode(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> ValueLength.decode
    ~> fn {length, value_bytes} ->
         value_bytes
         |> List.decode2(codecs)
         ~>> fn {data_type, _, details} -> decode_error bytes, [data_type, Map.merge(details, %{length: length})] end
         ~> fn {values, rest} -> ensure_correct_length(length, value_bytes, values, rest, bytes) end
       end
  end

  defp ensure_correct_length(length, value_bytes, values, rest, _bytes) when length == byte_size(value_bytes) - byte_size(rest) do
    ok values, rest
  end

  defp ensure_correct_length(length, value_bytes, values, rest, bytes) do
    decode_error bytes, %{length: length, bytes_used: byte_size(value_bytes) - byte_size(rest), values: values}
  end

  def encode(values, codecs) when is_list(values) and is_list(codecs) do
    values
    |> List.encode2(codecs)
    ~> fn value_bytes ->
         value_bytes
         |> byte_size
         |> ValueLength.encode
         ~> fn length_bytes -> ok length_bytes <> value_bytes end
       end
  end
end
