defmodule MMS.Length do
  @moduledoc """
  8.4.2.2 Length

  Length = Uintvar-integer
  """
  use MMS.As

  defcodec as: MMS.UintvarInteger

  defmacro decode_with_length bytes, length_codec, codec do
    quote bind_quoted: [bytes: bytes, codec: codec, length_codec: length_codec] do
      import MMS.As
      bytes
      |> decode_as(length_codec)
      ~> fn {length, rest} ->
          rest
          |> String.split_at(length)
          ~> fn {value_bytes, rest} ->
              value_bytes
              |> codec.decode
              ~>> fn {data_type, _, details} -> error bytes, [{data_type, details}] end
              ~> fn {value, extra} ->
                   used_bytes = byte_size(value_bytes) - byte_size(extra)
                   if used_bytes == length do
                     ok value, rest
                   else
                     error bytes, required_bytes: length, used_bytes: used_bytes
                   end
                 end
             end
         end
    end
  end

  defmacro encode_with_length value, length_codec, codec do
    quote bind_quoted: [value: value, codec: codec, length_codec: length_codec] do
      import MMS.As
      value
      |> encode_as(codec)
      ~> fn value_bytes ->
          value_bytes
          |> byte_size
          |> encode_as(length_codec)
          ~> fn length_bytes -> length_bytes <> value_bytes end
         end
    end
  end

  defmacro defcodec opts do
    codec = opts[:as]
    length_codec = opts[:length]

    quote do
      use MMS.Codec
      import MMS.As

      def decode bytes do
        bytes
        |> decode_with_length(unquote(length_codec), unquote(codec))
      end

      def encode value do
        value
        |> encode_with_length(unquote(length_codec), unquote(codec))
      end
    end
  end
end
