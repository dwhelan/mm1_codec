defmodule MMS.CodecMapper do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import MMS.OkError

      @decode_map  opts[:map]
      @codec_bytes Map.keys   @decode_map
      @codecs      Map.values @decode_map
      @error       opts[:error]

      def decode bytes do
        decode bytes, []
      end

      defp decode(<<byte, bytes:: binary>>, codecs) when byte in @codec_bytes do
        codec = @decode_map[byte]

        case codec.decode bytes do
          {:ok,    {value, rest}} -> decode rest, [{codec, value} | codecs]
          {:error,        reason} -> error codec, reason
        end
      end

      defp decode rest, values do
        ok Enum.reverse(values), rest
      end

      def encode values do
        encode values, []
      end

      defp encode [{codec, value} | values], results do
        case encode_one codec, value do
          {:ok,     bytes} -> encode values, [{codec, bytes} | results]
          {:error, reason} -> error codec, reason
        end
      end

      defp encode [], results do
        ok results |> Enum.reverse |> Enum.map(&prepend_codec_byte/1) |> Enum.join
      end

      defp encode_one(header, value) when header in @codecs do
        header.encode value
      end

      defp encode_one _, _ do
        error @error
      end

      @encode_map MMS.Mapper.reverse @decode_map

      defp prepend_codec_byte {codec, bytes} do
        <<@encode_map[codec]>> <> bytes
      end
    end
  end
end
