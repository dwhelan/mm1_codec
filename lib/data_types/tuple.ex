defmodule MMS.Tuple do
  use MMS.Codec

  def decode(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> MMS.List.decode(codecs)
    ~> fn {values, rest} -> decode_ok List.to_tuple(values), rest end
  end

  def encode(values, codecs) when is_tuple(values) and is_list(codecs) do
    values
    |> Tuple.to_list
    |> MMS.List.encode(codecs)
    ~>> fn {_, _, reason} -> error data_type(), values, reason end
  end
end
