defmodule MMS.Or do
  import OkError
  import CodecError

  defmacro decode bytes, codecs do
    quote do
      MMS.Or.decode(unquote(bytes), unquote(codecs), unquote(CodecError.data_type __CALLER__.module))
    end
  end

  def decode(bytes, codecs, data_type) when is_list(codecs) do
    Enum.reduce_while(codecs, error({data_type, bytes, []}), decode_one)
  end

  defp decode_one do
    fn codec, {:error, {data_type, bytes, errors}} ->
      case codec.decode(bytes) do
        {:ok, result} -> {:halt, ok(result)}
        {:error, {dt, _, details}} -> {:cont, error({data_type, bytes, errors ++ [{dt, details}]})}
      end
    end
  end

  defmacro encode value, codecs do
    quote do
      MMS.Or.encode(unquote(value), unquote(codecs), unquote(data_type __CALLER__.module))
    end
  end

  def encode value, codecs, data_type do
    Enum.reduce_while(codecs, error({data_type, value, []}), encode_one)
  end

  defp encode_one do
    fn codec, {:error, {data_type, value, errors}} ->
        case value |> codec.encode do
          {:ok, result} -> {:halt, ok(result)}
          {:error, {dt, _, details}} -> {:cont, error({data_type, value, errors ++ [{dt, details}]})}
        end
    end
  end
end
