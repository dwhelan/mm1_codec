defmodule MM1.Codecs.Mapper do
  import MM1.OkError

  def decode bytes, codec, map do
    bytes |> codec.decode |> map_value(map)
  end

  def encode value, codec, map do
    Map.get(map, value, value) |> codec.encode
  end

  defp map_value {:ok, {value, rest}}, map do
    ok {Map.get(map, value, value), rest}
  end

  defp map_value error, _ do
    error
  end

  def reverse(map) when is_map(map) do
    map |> Enum.reduce(%{}, fn {k, v}, reverse_map -> Map.put(reverse_map, v, k) end)
  end

  def indexed(values) when is_list(values) do
    values |> Enum.with_index |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  defmacro map codec, map do
    quote bind_quoted: [codec: codec, map: map] do
      alias MM1.Codecs.Mapper
      import Mapper

      @codec codec
      @map   map  |> indexed
      @unmap @map |> reverse

      def decode bytes do
        bytes |> decode(@codec, @map)
      end

      def encode value do
        value |> encode(@codec, @unmap)
      end
    end
  end

  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec], map: opts[:map], values: opts[:values]] do
      alias MM1.Codecs.Mapper
      import Mapper

      @codec codec
      @map   map  || indexed(values)
      @unmap @map |> reverse

      def decode bytes do
        bytes |> decode(@codec, @map)
      end

      def encode value do
        value |> encode(@codec, @unmap)
      end
    end
  end
end
