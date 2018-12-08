defmodule MM1.Codecs2.Composer do

  defmacro compose codecs do
    quote do
      import WAP.Guards

      @codecs unquote(codecs)

      def decode bytes do
        results = @codecs
                  |> Enum.reduce([ok(nil, bytes)], &decode_one/2)
                  |> Enum.reverse
                  |> tl

        if successful? results do
          ok value(results), rest(results)
        else
          error value(results), bytes
        end
      end

      def encode(values) when is_list(values) and length(values) == length(@codecs) do
        results = @codecs
                  |> Enum.with_index
                  |> Enum.map(fn {codec, index} -> codec.encode(Enum.at(values, index)) end)

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

      defp decode_one codec, results do
        case hd results do
          {:ok, {_, _, rest}} -> [codec.decode(rest) | results]
          error -> results
        end
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

      defp rest results do
        {_, {_, _, rest}} = Enum.at(results, -1)
        rest
      end

      defp successful? results do
        Enum.all?(results, fn {result, x} -> result == :ok end)
      end
    end
  end
end
