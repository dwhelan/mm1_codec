defmodule OkError.List do
  def insert(value, list), do: [value | list]
end

defmodule MMS.List do
  use MMS.Codec

  def decode bytes, codecs do
    codecs |> Enum.reduce(ok([], bytes), &do_decode/2) <|> Enum.reverse
  end

  defp do_decode codec, {:ok, {values, bytes}} do
    bytes |> codec.decode <|> OkError.List.insert(values)
  end

  def encode values, codecs do
    values |> Enum.zip(codecs) |> Enum.reduce(ok(<<>>), &do_encode/2)
  end

  defp do_encode {value, codec}, {:ok, bytes} do
    value |> codec.encode ~> prepend(bytes)
  end

  defmacro __using__ codecs \\ [] do
    build_codec codecs
  end

  defp build_codec(codecs) when is_list(codecs) do
    check codecs

    quote do
      import MMS.List

      def decode bytes do
        decode bytes, unquote(codecs)
      end

      def encode values do
        encode values, unquote(codecs)
      end
    end
  end

  defp check [] do
  end

  defp check codecs do
    if Keyword.keyword?(codecs) do
      raise ArgumentError, """
      "use MMS.List" expects to be passed a list of codecs. For example:


        defmodule MyCodec do
          use MMS.List, [MMS.Byte. MMS.Short]
        end
      """
    end
  end
end