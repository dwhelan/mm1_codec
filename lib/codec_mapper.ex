defmodule MMS.CodecMapper do
  def with_index(values) when is_list(values) do
    values |> Enum.with_index(128) |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import MMS.CodecMapper
      use MMS.Codec

      @decode opts[:map] || with_index(opts[:values])
      @codec_bytes @decode |> Map.keys   |> Enum.reject(& elem(@decode[&1], 0) == :_unassigned)
      @names       @decode |> Map.values |> Enum.map(& elem(&1, 0))

      @error       opts[:error]

      def decode bytes do
        bytes
        |> do_decode([])
      end

      defp do_decode(<<byte, bytes:: binary>>, codecs) when byte in @codec_bytes do
        {name, codec} = @decode[byte]

        bytes
        |> codec.decode
        ~> fn {value, rest} -> do_decode(rest, [{name, value} | codecs]) end
        ~>> fn details -> error {codec, details} end
      end

      defp do_decode rest, values do
        values
        |> Enum.reverse
        |> decode_ok(rest)
      end

      def encode values do
        values
        |> do_encode([])
      end

      @encode_map @decode |> Enum.reduce(%{}, fn {byte, {module, codec}}, map -> Map.put(map, module, {byte, codec}) end)

      defp do_encode([{name, value} | values], results) when name in @names do
        {byte, codec} = @encode_map[name]

        value
        |> codec.encode
        ~> fn bytes -> do_encode values, [<<byte>> <> bytes | results] end
        ~>> fn details -> error {name, details} end
      end

      defp do_encode [], results do
        results
        |> Enum.reverse
        |> Enum.join
        |> ok
      end

      defp do_encode [{name, value} | _], _  do
        error {name, @error}
      end
    end
  end
end

