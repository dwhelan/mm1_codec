defmodule OkError.Map do
  def get(value, map), do: Map.get map, value

  def from_list(list) when is_list(list) do
    list |> Enum.with_index |> Enum.reduce(%{}, fn {v, i}, map -> map |> Map.put(i, v) end)
  end

  def invert(map) when is_map(map) do
    map |> Enum.reduce(%{}, fn {k, v}, inverse -> inverse |> Map.put(v, k) end)
  end
end

defmodule MMS.Lookup do
  use MMS.Codec
  import OkError.Map

  def decode bytes, codec, map do
    bytes |> codec.decode <~> get(map)
  end

  def encode value, codec, unmap do
    value |> get(unmap) ~> codec.encode
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import OkError.Map
      import OkError

      @codec   opts[:codec] || MMS.Short
      @map     opts[:map]   || from_list opts[:values]
      @inverse invert @map

      def decode bytes do
        bytes |> @codec.decode <~> get(@map) ~>> module_error
      end

      def encode value do
        value |> get(@inverse) ~> @codec.encode ~>> module_error
      end
    end
  end
end
