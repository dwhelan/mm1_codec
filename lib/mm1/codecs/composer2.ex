defmodule MM1.Codecs2.Composer do

  defmacro compose codecs do
    quote do
      import WAP.Guards

      @codecs unquote(codecs)

      def decode bytes do
        decode bytes, @codecs, [], bytes
      end

      defp decode rest, [], results, _ do
        ok values(results), rest
      end

      defp decode rest, [codec | codecs], previous, bytes do
        result  = codec.decode rest
        results = previous ++ [result]

        case result do
          {:ok,    {value, rest}} -> decode rest, codecs, results, bytes
          {:error, reason}        -> error {codec, {reason, length(results)-1}}
        end
      end

      def encode(values) when is_list(values) and length(values) == length(@codecs) do
        values |> Enum.zip(@codecs) |> encode([])
      end

      def encode(values) when is_list(values) do
        error :incorrect_list_length
      end

      def encode(values) do
        error :must_be_a_list
      end

      defp encode [], results do
        ok bytes(results)
      end

      defp encode [{value, codec} | pairs], previous do
        result  = codec.encode value
        results = previous ++ [result]

        case result do
          {:ok, _}         -> encode pairs, results
          {:error, reason} -> error {codec, {reason, length(results)-1}}
        end
      end

      defp values results do
        results |> Enum.map(& value &1)
      end

      defp bytes results do
        results |> Enum.map(fn {:ok, bytes} -> bytes end) |> Enum.join
      end
    end
  end
end
