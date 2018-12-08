defmodule MM1.Codecs2.Composer do

  defmacro compose codecs do
    quote do
      import WAP.Guards

      @codecs unquote(codecs)

      def decode bytes do
        {results, rest} = decode(bytes, @codecs, [])

        case successful? results do
          true  ->    ok value(results), rest
          false -> error value(results), bytes
        end
      end

      defp decode rest, [], results do
        {results, rest}
      end

      defp decode bytes, codecs, results do
        [codec | codecs] = codecs
        {_, {_, _, rest}} = result = bytes |> codec.decode

        case result do
          {:ok,    _} -> decode rest, codecs, results ++ [result]
          {:error, _} -> {results ++ [result], rest}
        end
      end
      
      def encode(values) when is_list(values) and length(values) == length(@codecs) do
        results = @codecs
                  |> Enum.zip(values)
                  |> Enum.map(fn {codec, value} -> codec.encode(value) end)

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
