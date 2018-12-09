defmodule MM1.Codecs2.Composer do

  defmacro compose codecs do
    quote do
      import WAP.Guards

      @codecs unquote(codecs)

      def decode bytes do
        decode bytes, [], @codecs
      end

      defp decode bytes, values, [codec | codecs] do
        case codec.decode bytes do
          {:ok,    {value, rest}} -> decode rest, [value | values], codecs
          {:error, reason}        -> error {codec, {reason, length(values)}}
        end
      end

      defp decode rest, values, [] do
        ok {Enum.reverse(values), rest}
      end

      def encode(values) when is_list(values) == false do
        error :must_be_a_list
      end

      def encode(values) when length(values) != length(@codecs) do
        error :incorrect_list_length
      end

      def encode values do
        encode Enum.zip(values, @codecs), []
      end

      defp encode [{value, codec} | values], results do
        case codec.encode value do
          {:ok,    bytes}  -> encode values, results ++ [bytes]
          {:error, reason} -> error {codec, {reason, length(results)}}
        end
      end

      defp encode [], results do
        ok Enum.join results
      end
    end
  end
end
