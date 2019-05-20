defmodule MMS.Tuple do
  import MMS.Codec
  import MMS.As

  def decode bytes, codecs do
    bytes
    |> MMS.List.decode(codecs)
    |> map_value(&List.to_tuple/1)
  end

  def encode value, codecs do
    value
    |> Tuple.to_list
    |> MMS.List.encode(codecs)
  end

  defmacro defcodec(as: codecs) do
    quote do
      use MMS.Codec
      import MMS.Tuple

      def decode bytes do
        bytes
        |> decode(unquote codecs)
        ~>> fn {_, _, reason} -> error bytes, reason end
      end

      def encode(value) when is_tuple(value) do
        value
        |> encode(unquote codecs)
        ~>> fn {_, _, reason} -> error value, reason end
      end

      def encode value do
        error value, :out_of_range
      end
    end
  end
end
