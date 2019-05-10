defmodule MMS.Tuple do
  import OkError

  defmacro tuple_codec codecs do
    quote do
      use MMS.Codec

      def decode bytes do
        bytes
        |> MMS.List.decode(unquote codecs)
        |> map_value(&List.to_tuple/1)
        ~>> fn {_, _, reason} -> error data_type(), bytes, reason end
      end

      def encode value do
        value
        |> Tuple.to_list
        |> MMS.List.encode(unquote codecs)
        ~>> fn {_, _, reason} -> error data_type(), value, reason end
      end
    end
  end
end
