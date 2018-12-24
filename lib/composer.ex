defmodule MMS.Composer do
  import MMS.OkError

  alias MMS.Length

  def decode bytes, codecs do
    case_ok Length.decode bytes do
      {length, rest} -> do_decode rest, codecs, [], length
    end
  end

  defp do_decode rest, _, values, 0 do
    ok Enum.reverse(values), rest
  end

  defp do_decode(bytes, [codec | codecs], values, length) when length > 0 do
    case_ok codec.decode bytes do
      {value, rest} -> do_decode rest, codecs, [value | values], remaining(length, bytes, rest)
    end
  end

  defp do_decode(_, _, _, _) do
    error :incorrect_length
  end

  defp remaining length, bytes, rest do
    consumed = byte_size(bytes) - byte_size(rest)
    length - consumed
  end

  def encode [_|_] = values, [_|_] = codecs do
    do_encode Enum.zip(values, codecs), []
  end

  def encode _, _ do
    error :must_provide_at_least_one_value_and_codec
  end

  defp do_encode [{value, codec} | list], value_bytes do
    case_ok codec.encode value do
      bytes -> do_encode list, [bytes | value_bytes]
    end
  end

  defp do_encode [], value_bytes do
    bytes = value_bytes |> Enum.reverse |> Enum.join

    case_ok bytes |> byte_size |> Length.encode do
      length_bytes -> ok length_bytes <> bytes
    end
  end

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts ]do
      alias MMS.Composer

      @codecs opts[:codecs]

      def decode bytes do
        Composer.decode bytes, @codecs
      end

      def encode values do
        Composer.encode values, @codecs
      end
    end
  end
end
