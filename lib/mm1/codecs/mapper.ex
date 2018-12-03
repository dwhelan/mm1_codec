defmodule MM1.Codecs.Mapper do

  use MM1.Codecs.Checks

  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec], map: opts[:map], values: opts[:values]] do
      alias MM1.Codecs.Mapper
      import Mapper
      use MM1.Codecs.Extend

      @codec codec
      @map   if map, do: map, else: Mapper.ordinal_map(values)
      @unmap Mapper.invert @map

      def codec do
        @codec
      end

      def map result do
        %MM1.Result{result | module: __MODULE__, value: get(result.value, @map)}
      end

      def unmap value do
        get value, @unmap
      end

      defp get key, map do
        Map.get map, key, key
      end
    end
  end

  def decode bytes, module do
    bytes |> module.codec().decode |> module.map
  end

  def encode result, module do
    result |> module.codec().encode
  end

  def new value, module do
    value |> module.unmap |> module.codec().new |> module.map
  end

  def invert map do
    map |> Enum.reduce(%{}, fn {k,v}, unmap -> Map.put(unmap, v, k) end)
  end

  def ordinal_map values do
    values |> Enum.with_index |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end
end
