defmodule MMS.Lookup do
  import MMS.OkError

  def decode bytes, codec, map do
    case_ok codec.decode bytes do
      {value, rest} -> ok Map.get(map, value, value), rest
    end
  end

  def encode value, codec, map do
    Map.get(map, value, value) |> codec.encode
  end

  def indexed(values) when is_list(values) do
    values |> Enum.with_index(128) |> Enum.reduce(%{}, fn {v, i}, map -> Map.put(map, i, v) end)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import MMS.Lookup

      @decode_map indexed opts[:values]
      @encode_map MMS.Mapper.reverse @decode_map

      def decode bytes do
        decode bytes, MMS.Byte, @decode_map
      end

      def encode value do
        encode value, MMS.Byte, @encode_map
      end
    end
  end
end
