defmodule MMS.Either do
  defmacro defcodec as: codecs do
    quote do
      use MMS.Codec

      def decode bytes do
        bytes
        |> continue_until_ok(unquote(codecs), :decode)
      end

      def encode value do
        value
        |> continue_until_ok(unquote(codecs), :encode)
      end

      defp continue_until_ok input, codecs, function_name do
        codecs
        |> Enum.reduce_while(error([]),
             fn codec, {:error, errors} ->
               case apply codec, function_name, [input] do
                 {:ok, result} -> {:halt, ok result}
                 {:error, {data_type, _, details}} -> {:cont, error [{data_type, details} | errors]}
               end
             end)
        ~>> fn errors -> error input, Enum.reverse errors end
      end
    end
  end
end
