defmodule MMS.Mapper do
  import MMS.OkError

  def decode bytes, codec, map do
    bytes |> codec.decode |> map(map)
  end

  def encode value, codec, map do
    map |> get(value) |> codec.encode
  end

  defp map {:ok, {value, rest}}, map do
    ok get(map, value), rest
  end

  defp map error, _ do
    error
  end

  def get map, key do
    Map.get map, key, key
  end

  def reverse(map) when is_map(map) do
    map |> Enum.reduce(%{}, fn {k, v}, reverse_map -> Map.put(reverse_map, v, k) end)
  end

  def indexed(values) when is_list(values) do
    values |> Enum.with_index |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import MMS.Mapper

      @codec opts[:codec]
      @decode_map   opts[:map] || indexed(opts[:values])
      @unmap @decode_map |> reverse

      def decode bytes do
        bytes |> decode(@codec, @decode_map)
      end

      def encode value do
        value |> encode(@codec, @unmap)
      end
    end
  end
end
