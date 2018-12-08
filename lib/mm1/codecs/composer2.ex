defmodule MM1.Codecs2.Composer do

  defmacro compose codecs do
    quote do
      import WAP.Guards

      @codecs unquote(codecs)

      def decode bytes do
        results = @codecs
                  |> List.foldl([ok(nil, bytes)], &decode_one/2)
                  |> Enum.reverse
                  |> tl

        case result(results) do
          :ok    -> ok    value(results), rest(results)
          :error -> error value(results), bytes
        end
      end

      def encode(values) when is_list(values) and length(values) == length(@codecs) do
        results = @codecs
                  |> Enum.with_index
                  |> Enum.map(fn {codec, index} -> codec.encode(Enum.at(values, index)) end)
        {:ok, {bytes(results), __MODULE__, values}}
      end

      def encode(values) when is_list(values) do
        error :incorrect_list_length, values
      end

      def encode(values) do
        error :must_be_a_list, values
      end

      defp decode_one codec, results do
        previous = hd results
        case previous do
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

      defp result results do
        {result, _} = Enum.at(results, -1)
        result
      end
#
#      defp error results do
#        errors = Enum.map(results, & &1.err)
#        if Enum.all?(errors, &is_nil &1), do: nil, else: errors
#      end
#
#      defp bytes results do
#        {_, bytes} = List.foldl(results, {[%Result{}], <<>>},
#          fn result, {results, bytes} ->
#            if hd(results).err, do: {results, bytes}, else: {[result | results], bytes <> result.bytes}
#          end)
#        bytes
#      end
#
#      defp result results do
#        Enum.at(results, -1).rest
#      end
#
    end
  end
end
