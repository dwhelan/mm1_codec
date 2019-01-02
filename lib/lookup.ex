defmodule MMS.Lookup do
  import MMS.OkError

  def decode bytes, codec, map do
    case_ok codec.decode bytes do
      {value, rest} -> map {value, rest}, map
    end
  end

  defp map {value, rest}, map do
    case Map.get(map, value) do
      nil -> error()
      value -> ok value, rest
    end
  end

  def encode value, codec, map do
    Map.get(map, value, value) |> codec.encode
  end

  def indexed(values) when is_list(values) do
    values |> Enum.with_index(0) |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import MMS.Lookup
      import MMS.OkError

      @codec      opts[:codec] || MMS.Short
      @decode_map opts[:map]   || indexed(opts[:values])
      @encode_map MMS.Mapper.reverse @decode_map

      def decode bytes do
        bytes |> decode(@codec, @decode_map) ~>> module_error
      end

      def encode value do
        encode value, @codec, @encode_map
      end
    end
  end
end
