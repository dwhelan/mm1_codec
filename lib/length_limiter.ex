defmodule MMS.LengthLimiter do
  @moduledoc """
  """

  defmacro defcodec opts do
    codec = opts[:as]
    length_codec = opts[:length]

    quote do
      use MMS.Codec
      import MMS.As

      def decode bytes do
        bytes
        |> decode_as(unquote length_codec)
        ~> fn {length, rest} ->
            rest
            |> String.split_at(length)
            ~> fn {value_bytes, rest} ->
                value_bytes
                |> (unquote codec).decode
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

      def encode value do
        value
        |> encode_as(unquote codec)
        ~> fn value_bytes ->
            value_bytes
            |> byte_size
            |> encode_as(unquote length_codec)
            ~> fn length_bytes -> length_bytes <> value_bytes end
           end
      end
    end
  end
end
