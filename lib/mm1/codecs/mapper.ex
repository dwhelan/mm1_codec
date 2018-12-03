defmodule MM1.Codecs.Mapper do
  def decode bytes, codec, module, map do
    bytes |> codec.decode |> map(module, map)
  end

  def encode result, codec, _module do
    result |> codec.encode
  end

  def new value, codec, module, map, unmap do
    value |> get(unmap) |> codec.new |> map(module, map)
  end

  defp map result, module, map do
    %MM1.Result{result | module: module, value: get(result.value, map)}
  end

  def get_map do

  end

  defp get key, map do
    Map.get map, key, key
  end

  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec], map: opts[:map]] do
      @codec codec
      @map   map
      @unmap MM1.Codecs.Mapper.unmap map

      def decode bytes do
        bytes |> @codec.decode |> map
      end

      def encode result do
        result |> @codec.encode
      end

      def new value do
        value |> get(@unmap) |> @codec.new |> map
      end

      defp map result do
        %MM1.Result{result | module: __MODULE__, value: get(result.value, @map)}
      end

      defp get key, map do
        Map.get map, key, key
      end
    end
  end

  def unmap map do
    map |> Enum.reduce(%{}, fn {k,v}, unmap -> Map.put(unmap, v, k) end)
  end

  def ordinal_map values do
    values |> Enum.with_index |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end
end
