defmodule MM1.Codecs.Mapper do

  use MM1.Codecs.Checks

  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec], map: opts[:map], values: opts[:values]] do
      alias MM1.Codecs.Mapper
      import Mapper
      use MM1.Codecs.Extend

      @codec codec
      @map   if map, do: map, else: values |> Enum.with_index |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
      @unmap @map |> Enum.reduce(%{}, fn {k,v}, unmap -> Map.put(unmap, v, k) end)

      def codec do
        @codec
      end

      def map result_value do
        Map.get @map, result_value, result_value
      end

      def unmap mapped_value do
        Map.get @unmap, mapped_value, mapped_value
      end
    end
  end

  def decode bytes, module do
    bytes |> module.codec().decode |> map(module)
  end

  def encode result, module do
    result |> module.codec().encode
  end

  def new value, module do
    value |> module.unmap |> module.codec().new |> map(module)
  end

  def map result, module do
    %MM1.Result{result | module: module, value: module.map(result.value)}
  end
end
