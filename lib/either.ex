defmodule MMS.Either do
  import OkError

  def decode bytes, codecs do
    bytes |> apply_until_ok(codecs, :decode)
  end

  def encode value, codecs do
    value |> apply_until_ok(codecs, :encode)
  end

  def apply_until_ok input, codecs, function_name do
    Enum.reduce_while(codecs, nil, fn codec, _ ->
      case result = apply(codec, function_name, [input]) do
        {:ok, _} -> {:halt, result}
        _        -> {:cont, result}
      end
    end)
  end

  defmacro __using__ types \\ [] do
    check_types types

    quote do
      use MMS.Codec
      import MMS.Either
      import OkError.Module

      def decode bytes do
        bytes ~> decode(unquote(types)) ~>> OkError.Module.module_error()
      end

      def encode value do
        value |> encode(unquote(types)) ~>> OkError.Module.module_error()
      end
    end
  end

  defp check_types types do
    if Keyword.keyword?(types) do
      raise ArgumentError, """
        "use MMS.Either" expects to be passed a list of codecs. For example:


          defmodule MyCodec do
            use MMS.Either, [MMS.Byte. MMS.Short]
          end
        """
    end
  end
end
