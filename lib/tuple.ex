defmodule MMS.Tuple do
  defmacro defcodec(as: codecs) do
    quote do
      use MMS.Codec

      def decode bytes do
        bytes
        |> MMS.List.decode(unquote codecs)
        |> map_value(&List.to_tuple/1)
        ~>> fn {_, _, reason} -> error data_type(), bytes, reason end
      end

      def encode(value) when is_tuple(value) do
        value
        |> Tuple.to_list
        |> MMS.List.encode(unquote codecs)
        ~>> fn {_, _, reason} -> error data_type(), value, reason end
      end

      def encode value do
        error value, :out_of_range
      end
    end
  end
end
