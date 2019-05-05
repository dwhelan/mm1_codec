defmodule MMS.Either do
  import OkError
  import MMS.Codec

  defmacro defcodec either: codecs do
    data_type = data_type __CALLER__.module
    quote do
      def decode bytes do
        bytes
        |> decode(unquote(codecs), unquote(data_type))
      end

      def encode value do
        value
        |> encode(unquote(codecs), unquote(data_type))
      end
    end
  end

  def decode(bytes, codecs, data_type) when is_list(codecs) do
    Enum.reduce_while(codecs, error({data_type, bytes, []}), decode_one())
  end

  defp decode_one do
    fn codec, {:error, {data_type, bytes, errors}} ->
      case bytes |> codec.decode do
        {:ok, result} -> {:halt, ok result}
        {:error, {dt, _, details}} -> {:cont, error({data_type, bytes, errors ++ [{dt, details}]})}
      end
    end
  end

  def encode value, codecs, data_type do
    Enum.reduce_while(codecs, error({data_type, value, []}), encode_one())
  end

  defp encode_one do
    fn codec, {:error, {data_type, value, errors}} ->
        case value |> codec.encode do
          {:ok, result} -> {:halt, ok result}
          {:error, {dt, _, details}} -> {:cont, error({data_type, value, errors ++ [{dt, details}]})}
        end
    end
  end

  defmacro __using__ (_) do
    quote do
      use MMS.Codec
      import MMS.Either
    end
  end
end
