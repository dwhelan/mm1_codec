defmodule MMS.Mapper do
  import MMS.OkError

  def decode bytes, codec, map do
    case_ok codec.decode bytes do
      {value, rest} -> ok get(map, value), rest
    end
  end

  def encode value, codec, map do
    get(map, value) |> codec.encode
  end

  defp get map, key do
    Map.get map, key, key
  end

  def reverse(map) when is_map(map) do
    map |> Enum.reduce(%{}, fn {k, v}, reverse_map -> Map.put(reverse_map, v, k) end)
  end

  def indexed(values, offset \\ 0) when is_list(values) do
    values |> Enum.with_index(offset || 0) |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import MMS.Mapper

      @codec      opts[:codec]
      @decode_map opts[:map] || indexed(opts[:values], opts[:offset])
      @encode_map reverse @decode_map

      def decode bytes do
        bytes |> decode(@codec, @decode_map)
      end

      def encode value do
        value |> encode(@codec, @encode_map)
      end
    end
  end
end
