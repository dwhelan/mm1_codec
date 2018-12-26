defmodule MMS.CodecMapper2 do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import MMS.OkError

      @decode_map  opts[:map]
      @codec_bytes Map.keys @decode_map
      @modules       @decode_map |> Map.values |> Enum.map(& elem(&1, 1))

      @error       opts[:error]

      def decode bytes do
        decode bytes, []
      end

      defp decode(<<byte, bytes:: binary>>, codecs) when byte in @codec_bytes do
        {module, codec} = @decode_map[byte]

        case codec.decode bytes do
          {:ok,    {value, rest}} -> decode rest, [{module, value} | codecs]
          {:error,        reason} -> error codec, reason
        end
      end

      defp decode rest, values do
        ok Enum.reverse(values), rest
      end

      def encode values do
        encode values, []
      end

      @encode_map @decode_map |> Enum.reduce(%{}, fn {byte, {module, codec}}, map -> Map.put(map, module, {byte, codec}) end)

      defp encode([{module, value} | values], results) when module in @modules do
        {byte, codec} = @encode_map[module]

        case codec.encode value do
          {:ok,     bytes} -> encode values, [<<byte>> <> bytes | results]
          {:error, reason} -> error module, reason
        end
      end

      defp encode [], results do
        ok results |> Enum.reverse |> Enum.join
      end

      defp encode _, _ do
        error @error
      end
    end
  end
end

defmodule MMS.WellKnownParameters do
  # Based on WAP-230-WSP-20010705-a: Table 38. Well-Known Parameter Assignments
  #
  # The byte keys below are expressed as integers so they start at 128 (short-integer 0)

  use MMS.CodecMapper2,
      map: %{
         128 => {MMS.Q, MMS.Q},
         129 => {MMS.Charset, MMS.Charset},
      },
      error: :invalid_well_known_parameter
end
