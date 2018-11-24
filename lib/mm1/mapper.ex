defmodule MM1.Mapper do
  defmacro build_mapper(map) do
    quote bind_quoted: [map: map] do
      @map   map
      @unmap Enum.reduce @map, %{}, fn {k,v}, acc -> Map.put(acc, v, k) end

      alias MM1.Result

      def map %Result{} = result do
        %Result{result | value: map(result.value)}
      end

      def map value do
        @map[value] || value
      end

      def unmap %Result{} = result do
        %Result{result | value: unmap(result.value)}
      end

      def unmap value do
        @unmap[value] || value
      end
    end
  end
end
