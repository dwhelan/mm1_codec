defmodule MMS.Map do
  import MMS.OkError

  def get value, map do
    case Map.get(map, value) do
      nil   -> error()
      value -> value
    end
  end
end

defmodule MMS.Lookup do
  use MMS.Codec

  def decode bytes, codec, map do
    bytes |> codec.decode <~> MMS.Map.get(map)
  end

  def encode value, codec, unmap do
    value |> MMS.Map.get(unmap) ~> codec.encode
  end

  def indexed(values) when is_list(values) do
    values |> Enum.with_index(0) |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  def invert(map) when is_map(map) do
    map |> Enum.reduce(%{}, fn {k, v}, reverse_map -> Map.put(reverse_map, v, k) end)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import MMS.Lookup
      import MMS.OkError

      @codec      opts[:codec] || MMS.Short
      @decode_map opts[:map]   || indexed(opts[:values])
      @encode_map invert @decode_map

      def decode bytes do
        bytes |> decode(@codec, @decode_map) ~>> module_error
      end

      def encode value do
        value |> encode(@codec, @encode_map) ~>> module_error
      end
    end
  end
end
