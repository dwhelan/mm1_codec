defmodule MMS.Tuple do
  import MMS.DataTypes
  use MMS.Codec

  def decode(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> MMS.List.decode(codecs)
    ~> fn {values, rest} -> ok List.to_tuple(values), rest end
    ~>> fn {_, _, reason} -> error data_type(), bytes, reason end
  end

  def encode(values, codecs) when is_tuple(values) and is_list(codecs) do
    values
    |> Tuple.to_list
    |> MMS.List.encode(codecs)
    ~>> fn {_, _, reason} -> error data_type(), values, reason end
  end

  defmacro defcodec as: codecs do
    quote do
      use MMS.Codec
      import MMS.Tuple

      def decode bytes do
        bytes
        |> decode(unquote codecs)
      end

      def encode {name, value} do
        {name, value}
        |> encode(unquote codecs)
      end
    end
  end
end
