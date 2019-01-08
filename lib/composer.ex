defmodule MMS.Composer do
  use MMS.Codec

  alias MMS.Length

  def decode bytes, codecs do
    bytes |> Length.decode ~> do_decode(codecs)
  end

  defp do_decode {length, rest}, codecs do
    do_decode rest, codecs, [], length
  end

  defp do_decode rest, _, values, 0 do
    ok List.to_tuple(values), rest
  end

  defp do_decode <<>>, _, _, _ do
    error :incorrect_length
  end

  defp do_decode(bytes, [codec | codecs], values, length) when length > 0 do
    case bytes |> codec.decode do
      {:ok, {value, rest}} -> do_decode rest, remaining(codec, codecs), [value | values], length - consumed(bytes, rest)
      error                -> error
    end
  end

  defp remaining codec, [] do
    [codec]
  end

  defp remaining _codec, codecs do
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
    case value |> codec.encode do
      {:ok, bytes} -> do_encode list, [bytes | value_bytes]
      error        -> error
    end
  end

  defp do_encode [], value_bytes do
    bytes = value_bytes |> Enum.reverse |> Enum.join

    case bytes |> byte_size |> Length.encode do
      {:ok, length_bytes} -> ok length_bytes <> bytes
      error -> error
    end
  end

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts ]do
      use MMS.Codec
      import MMS.Composer

      @codecs opts[:codecs]

      def decode bytes do
        decode bytes, @codecs
      end

      def encode(values) when is_tuple(values) do
        encode values |> Tuple.to_list |> Enum.reverse, @codecs
      end

    end
  end
end
