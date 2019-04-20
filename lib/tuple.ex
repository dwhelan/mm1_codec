defmodule MMS.Tuple do
  use MMS.Codec

  def decode(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> MMS.List.decode(codecs)
    ~> fn {values, rest} -> ok List.to_tuple(values), rest end
  end

  def decode(bytes, codecs) when is_binary(bytes) and is_tuple(codecs) do
    bytes
    |> MMS.List.decode(Tuple.to_list codecs)
    ~> fn {values, rest} -> ok List.to_tuple(values), rest end
  end

  def encode(values, codecs) when is_tuple(values) and is_list(codecs) do
    values
    |> Tuple.to_list
    |> MMS.List.encode(codecs)
    ~>> fn {_, _, reason} -> error data_type(), values, reason end
  end

  def encode(values, codecs) when is_tuple(values) and is_tuple(codecs) do
    values
    |> Tuple.to_list
    |> MMS.List.encode(Tuple.to_list codecs)
    ~>> fn {_, _, reason} -> error data_type(), values, reason end
  end

  defmacro defcodec opts do
    codecs = opts[:as]
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

  defmacro __using__ (_) do
    quote do
      use MMS.Codec
      import MMS.Tuple
    end
  end

end
