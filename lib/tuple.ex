defmodule MMS.Tuple do
  import MMS.Codec
  import OkError.Operators
  import MMS.As

  def decode bytes, codecs do
    bytes
    |> MMS.List.decode(Tuple.to_list codecs)
    |> map_value(&List.to_tuple/1)
  end

  def encode(value, codecs) when is_tuple(value) do
    value
    |> Tuple.to_list
    |> MMS.List.encode(Tuple.to_list codecs)
    ~>> fn {data_type, _, details} -> error data_type, value, details end
  end

  def encode(value, codecs) do
    error value, :out_of_range
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
