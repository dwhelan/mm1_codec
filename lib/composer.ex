defmodule MMS.Composer do
  import MMS.OkError

  alias MMS.Length

  def decode bytes, codecs do
    case_ok Length.decode bytes do
      {length, rest} -> do_decode rest, codecs, [], length
    end
  end

  defp do_decode rest, _, values, 0 do
    ok List.to_tuple(values), rest
  end

  defp do_decode(<<>>, _, _, _) do
    error :incorrect_length
  end

  defp do_decode(bytes, [codec | codecs], values, length) when length > 0 do
    case_ok codec.decode bytes do
      {value, rest} -> do_decode rest, remaining(codec, codecs), [value | values], length - consumed(bytes, rest)
    end
  end

  defp remaining codec, [] do
    [codec]
  end

  defp remaining codec, codecs do
    codecs
  end

  defp consumed bytes, rest do
    byte_size(bytes) - byte_size(rest)
  end

  def encode [], _  do
    ok <<>>
  end

  def encode values, codecs do
    do_encode Enum.zip(values, codecs), []
  end

  defp do_encode [{value, codec} | list], value_bytes do
    case_ok codec.encode value do
      bytes -> do_encode list, [bytes | value_bytes]
    end
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

      def encode(values) when is_tuple(values) do
        Composer.encode values |> Tuple.to_list |> Enum.reverse, @codecs
      end
    end
  end
end
