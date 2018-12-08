defmodule MM1.Codecs2.Composer do

  defmacro compose codecs do
    quote do
      import WAP.Guards

      @codecs unquote(codecs)

      def decode bytes do
        results = @codecs
                  |> Enum.reduce_while([], fn codec, previous ->
                        result  = previous |> remaining(bytes) |> codec.decode
                        previous ++ [result] |> halt_after_error result
                      end)

        case successful? results do
          true  ->    ok value(results), remaining(results, bytes)
          false -> error value(results), bytes
        end
      end

      defp remaining [], bytes do
        bytes
      end

      defp remaining results, _bytes do
         {_, {_, _, rest}} = Enum.at(results, -1)
         rest
      end

      def halt_after_error results, result do
        case result do
          {:ok,    _} -> {:cont, results}
          {:error, _} -> {:halt, results}
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
