defmodule MMS.Either do
  import OkError
  import OkError.Operators
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

  def decode(bytes, codecs, data_type) when is_binary(bytes) and is_list(codecs) and is_atom(data_type) do
    continue_until_ok bytes, codecs, data_type, :decode
  end

  def encode(value, codecs, data_type) when is_list(codecs) and is_atom(data_type) do
    continue_until_ok value, codecs, data_type, :encode
  end

  defp continue_until_ok input, codecs, data_type, function_name do
    codecs
    |> Enum.reduce_while(error([]), call(function_name, input))
    ~>> fn errors -> error data_type, input, Enum.reverse errors end
  end

  defp call function_name, input do
    fn codec, {:error, errors} ->
      case apply codec, function_name, [input] do
        {:ok, result} -> {:halt, ok result}
        {:error, {codec_data_type, _, details}} -> {:cont, error([{codec_data_type, details} | errors])}
      end
    end
  end

  defmacro __using__ _ do
    quote do
      use MMS.Codec
      import MMS.Either
    end
  end

  """
  Available operators:
    <<-
    ->> error
    <-
    -> ok
    <->
  """
end
