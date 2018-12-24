defmodule MMS.Mapper do
  import MMS.OkError

  def decode bytes, codec, map do
    case_ok codec.decode bytes do
      {value, rest} -> ok Map.get(map, value, value), rest
    end
  end

  def encode value, codec, map do
    Map.get(map, value, value) |> codec.encode
  end

  def reverse(map) when is_map(map) do
    map |> Enum.reduce(%{}, fn {k, v}, reverse_map -> Map.put(reverse_map, v, k) end)
  end

  def indexed(values, offset \\ 0) when is_list(values) do
    values |> Enum.with_index(offset) |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import MMS.Mapper

      @codec      opts[:codec]
      @decode_map opts[:map] || indexed(opts[:values], opts[:offset] || 0)
      @encode_map reverse @decode_map

      def decode bytes do
        decode bytes, @codec, @decode_map
      end

      def encode value do
        encode value, @codec, @encode_map
      end
    end
  end
end
