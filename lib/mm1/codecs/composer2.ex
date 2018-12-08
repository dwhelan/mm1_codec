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
          {:ok,    {_,     _, rest}} -> decode rest, codecs, results, bytes
          {:error, {error, _, _   }} -> error {error, length(results)-1}, bytes
        end
      end

      def encode(values) when is_list(values) and length(values) == length(@codecs) do
        values |> Enum.zip(@codecs) |> encode([], values)
      end

      def encode(values) when is_list(values) do
        error {:incorrect_list_length, length(values), length(@codecs)}, values
      end

      def encode(values) do
        error :must_be_a_list, values
      end

      defp encode [], results, values do
        ok bytes(results), values
      end

      defp encode [{value, codec} | pairs], previous, values do
        result  = codec.encode value
        results = previous ++ [result]

        case result do
          {:ok,    _}             -> encode pairs, results, values
          {:error, {error, _, _}} -> error {error, length(results)-1}, values
        end
      end

      defp values results do
        results |> Enum.map(& value &1)
      end

      defp bytes results do
        results |> values |> Enum.join
      end
    end
  end
end
