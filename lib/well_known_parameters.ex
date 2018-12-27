defmodule MMS.CodecMapper2 do
  def indexed(values) when is_list(values) do
    values |> Enum.with_index(128) |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import MMS.CodecMapper2
      import MMS.OkError

      @decode_map opts[:map] || indexed(opts[:values])
      @codec_bytes @decode_map |> Map.keys   |> Enum.reject(& @decode_map[&1] == {:unassigned, :error})
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
  #
  # The byte keys below are expressed as integers so they start at 128 (short-integer 0)

  alias MMS.{Charset, Integer, Q, Media, NoValue, Short, TextString, TextValue, Version}

  use MMS.CodecMapper2,
      values: [
        q:                     Q,
        charset:               Charset,
        level:                 Version,
        type:                  Integer,
        unassigned:            :error,
        name:                  TextString,
        file_name:             TextString,
        differences:           TextString, # Note: defined in spec as Field-name, we shall simplify to TextString
        padding:               Short,
        type_multipart:        Media,  # Equivalent to Constrained-encoding
        start_deprecated:      TextString,
        start_info_deprecated: TextString,
        comment_deprecated:    TextString,
        domain_deprecated:     TextString,
        max_age:               Integer,    # Equivalent to Delta-seconds-value
        path_deprecated:       TextString,
        secure:                NoValue,
        sec:                   Short,
        mac:                   TextValue,
        creation_date:         MMS.DateTime,
      ],
      error: :invalid_well_known_parameter
end
