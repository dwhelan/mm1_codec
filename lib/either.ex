defmodule MMS.Either do
  import OkError
  import MMS.Codec, only: [data_type: 1, error: 3]

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
    continue_until_ok bytes, codecs, data_type, :decode
  end

  def encode value, codecs, data_type do
    continue_until_ok value, codecs, data_type, :encode
  end

  defp continue_until_ok input, codecs, data_type, function_name do
    Enum.reduce_while codecs, error(data_type, input, []), apply(function_name)
  end

  defp apply function_name do
    fn codec, {:error, {data_type, input, errors}} ->
      case apply codec, function_name, [input] do
        {:ok, result} -> {:halt, ok result}
        {:error, {error_data_type, _, details}} -> {:cont, error(data_type, input, errors ++ [{error_data_type, details}])}
      end
    end
  end

  defmacro __using__ _ do
    quote do
      use MMS.Codec
      import MMS.Either
    end
  end
end
