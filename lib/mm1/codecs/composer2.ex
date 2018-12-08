defmodule MM1.Codecs2.Composer do

  defmacro compose codecs do
    quote do
      import WAP.Guards

      @codecs unquote(codecs)

      def decode bytes do
        decode bytes, @codecs, [], bytes
      end

      defp decode rest, [], results, _ do
        ok value(results), rest
      end

      defp decode rest, [codec | codecs], previous, bytes do
        result  = codec.decode rest
        results = previous ++ [result]

        case result do
          {:ok,    _}             -> decode rest(result), codecs, results, bytes
          {:error, {error, _, _}} -> error {error, length(results)-1}, bytes
        end
      end

      defp value results do
        results |> Enum.map(fn {_, {value, _, _}} -> value end)
      end

      def encode(values) when is_list(values) and length(values) == length(@codecs) do
        encode Enum.zip(@codecs, values), [], values
      end

      defp encode [], results, values do
        ok bytes(results), values
      end

      defp encode [{codec, value} | codecs], previous, values do
        result  = codec.encode value
        results = previous ++ [result]

        case result do
          {:ok,    _}             -> encode codecs, results, values
          {:error, {error, _, _}} -> error {error, length(results)-1}, values
        end
      end

      def encode(values) when is_list(values) do
        error :incorrect_list_length, values
      end

      def encode(values) do
        error :must_be_a_list, values
      end

      defp bytes results do
        results |> Enum.reduce(<<>>, fn result, bytes ->
          case result do
            {:ok, {value, _, _}} -> bytes <> value
            _ -> bytes
          end
          end)
      end
    end
  end
end
