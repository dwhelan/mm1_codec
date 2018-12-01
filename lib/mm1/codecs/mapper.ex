defmodule MM1.Codecs.Mapper do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec], map: opts[:map]] do
      @codec codec
      @map   map
      @unmap Enum.reduce map, %{}, fn {k,v}, unmap -> Map.put(unmap, v, k) end

      alias MM1.Result

      def decode bytes do
        bytes |> @codec.decode |> map
      end

      def encode %Result{module: __MODULE__} = result do
        %Result{result | module: @codec} |> @codec.encode
      end

      def new value do
        value |> get(@unmap) |> @codec.new |> map
      end

      defp map result do
        %Result{result | module: __MODULE__, value: get(result.value, @map)}
      end

      defp get key, map do
        Map.get map, key, key
      end
    end
  end

  def ordinal_map values do
    values |> Enum.with_index |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end
end
