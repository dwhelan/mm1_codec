defmodule MMS.ValueLength do
  @moduledoc """
  8.4.2.2 Length

  The following rules are used to encode length indicators.

  Value-length = Short-length | (Length-quote Length)
               = Short-length | Quoted-length

  Value length is used to indicate the length of the value to follow.
  """
  use MMS.Either

  defcodec either: [MMS.ShortLength, MMS.QuotedLength]

  defmacro decode_as(bytes, codec) do
    quote bind_quoted: [bytes: bytes, codec: codec] do
      bytes
      |> MMS.ValueLength.decode
      ~>> fn {data_type, bytes, details} -> error bytes, [{data_type, details}]  end
      ~> fn {value_length, value_bytes} ->
          value_bytes
          |> codec.decode()
          ~>> fn {data_type, _, details} -> error bytes, [{data_type, details}] end
          ~> fn {value, rest} ->
               used_bytes = byte_size(value_bytes) - byte_size(rest)
               if used_bytes == value_length do
                 ok value, rest
               else
                 error bytes, value_length: [required_bytes: value_length, used_bytes: used_bytes]
               end
             end
         end
    end
  end

  defmacro encode_as(value, codec) do
    quote bind_quoted: [value: value, codec: codec] do
      value
      |> codec.encode
      ~>> fn {data_type, _, reason} -> error value, [{data_type, reason}] end
      ~> fn value_bytes ->
          value_bytes
          |> byte_size
          |> MMS.ValueLength.encode
          ~>> fn {data_type, _, reason} -> error value, [{data_type, reason}] end
          ~> & (&1 <> value_bytes)
         end
    end
  end
end
