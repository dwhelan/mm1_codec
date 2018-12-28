defmodule MMS.CodecMapper2 do
  def indexed(values) when is_list(values) do
    values |> Enum.with_index(128) |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import MMS.CodecMapper2
      import MMS.OkError

      @decode_map opts[:map] || indexed(opts[:values])
      @codec_bytes @decode_map |> Map.keys   |> Enum.reject(& elem(@decode_map[&1], 0) == :unassigned)
      @names       @decode_map |> Map.values |> Enum.map(& elem(&1, 0))

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

      defp encode([{name, value} | values], results) when name in @names do
        {byte, codec} = @encode_map[name]

        case codec.encode value do
          {:ok,     bytes} -> encode values, [<<byte>> <> bytes | results]
          {:error, reason} -> error name, reason
        end
      end

      defp encode [], results do
        ok results |> Enum.reverse |> Enum.join
      end

      defp encode [{name, value} | _], _  do
        error {name, @error}
      end
    end
  end
end

defmodule MMS.WellKnownParameters do
  # Based on WAP-230-WSP-20010705-a: Table 38. Well-Known Parameter Assignments

  alias MMS.{Charset, DateTime, Integer, Q, Media, NoValue, Short, TextString, TextValue, Version}

  alias Media,      as: ConstrainedEncoding
  alias Integer,    as: DeltaSecondsValue
  alias TextString, as: FieldName

  use MMS.CodecMapper2,
      values: [
        q:                     Q,
        charset:               Charset,
        level:                 Version,
        type:                  Integer,
        unassigned:            nil,
        name_deprecated:       TextString,
        file_name_deprecated:  TextString,
        differences:           FieldName,
        padding:               Short,
        type_multipart:        ConstrainedEncoding,
        start_deprecated:      TextString,
        start_info_deprecated: TextString,
        comment_deprecated:    TextString,
        domain_deprecated:     TextString,
        max_age:               DeltaSecondsValue,
        path_deprecated:       TextString,
        secure:                NoValue,
        sec:                   Short,
        mac:                   TextValue,
        creation_date:         DateTime,
        modification_date:     DateTime,
        read_date:             DateTime,
        size:                  Integer,
        name:                  TextValue,
        file_name:             TextValue,
        start:                 TextValue,
        start_info:            TextValue,
        comment:               TextValue,
        domain:                TextValue,
        path:                  TextValue,
      ],
      error: :invalid_well_known_parameter
end
