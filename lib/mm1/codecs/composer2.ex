defmodule MM1.Codecs2.Composer do

  defmacro compose codecs do
    quote do
      import WAP.Guards

      @codecs unquote(codecs)

      def decode bytes do
        decode [], bytes, @codecs
      end

      defp decode values, rest, [] do
        ok values, rest
      end

      defp decode values, rest, [codec | codecs] do
        case codec.decode rest do
          {:ok,    {value, rest}} -> decode values ++ [value], rest, codecs
          {:error, reason}        -> error {codec, {reason, length(values)}}
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
        results = previous ++ [result]

        case result do
          {:ok, _}         -> encode pairs, results
          {:error, reason} -> error {codec, {reason, length(results)-1}}
        end
      end

      defp bytes results do
        results |> Enum.map(fn {:ok, bytes} -> bytes end) |> Enum.join
      end
    end
  end
end
