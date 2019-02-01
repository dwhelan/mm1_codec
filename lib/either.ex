defmodule Either do
  defmodule Decode do
    import Codec.Decode

    def decode <<byte, rest::binary>> do
      ok byte, rest
    end
  end

  defmodule Encode do
    import Codec.Encode
    import OkError

    def encode(byte) do
      ok <<byte>>
    end

    def encode value do
      error :invalid_byte, value
    end
  end
end

defmodule MMS.Either do
  use MMS.Codec

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

      def decode bytes do
        bytes ~> decode(unquote(types)) ~>> module_error
      end

      def encode value do
        value |> encode(unquote(types)) ~>> module_error()
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
