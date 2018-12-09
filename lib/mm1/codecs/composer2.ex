defmodule MM1.Codecs2.Composer do

  defmacro compose codecs do
    quote do
      import WAP.Guards

      @codecs unquote(codecs)

      def decode bytes do
        decode bytes, [], @codecs
      end

      defp decode rest, values, [codec | codecs] do
        case codec.decode rest do
          {:ok,    {value, rest}} -> decode rest, values ++ [value], codecs
          {:error, reason}        -> error {codec, {reason, length(values)}}
        end
      end

      defp decode rest, values, [] do
        ok values, rest
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
        ok Enum.join results
      end

      defp encode [{value, codec} | values], results do
        case codec.encode value do
          {:ok,    bytes}  -> encode values, results ++ [bytes]
          {:error, reason} -> error {codec, {reason, length(results)}}
        end
      end
    end
  end
end
