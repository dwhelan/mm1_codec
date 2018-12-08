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

      defp decode rest, codecs, previous, bytes do
        result  = hd(codecs).decode rest
        results = previous ++ [result]

        case result do
          {:ok,    _}             -> decode rest(result), tl(codecs), results, bytes
          {:error, {error, _, _}} -> error {error, length(results)-1}, bytes
        end
      end

      def encode(values) when is_list(values) and length(values) == length(@codecs) do
        results = @codecs
                  |> Enum.zip(values)
                  |> Enum.map(fn {codec, value} -> codec.encode(value) end)

        IO.inspect results
        if successful? results do
          ok bytes(results), values
        else
          error value(results), values
        end
      end

      def encode(values) when is_list(values) do
        error :incorrect_list_length, values
      end

      def encode(values) do
        error :must_be_a_list, values
      end

      defp value results do
        results |> Enum.map(fn {_, {value, _, _}} -> value end)
      end

      defp bytes results do
        results |> Enum.reduce(<<>>, fn result, bytes ->
          case result do
            {:ok, {value, _, _}} -> bytes <> value
            _ -> bytes
          end
          end)
      end

      defp successful? results do
        results |> Enum.all?(fn {result, _} -> result == :ok end)
      end
    end
  end
end
