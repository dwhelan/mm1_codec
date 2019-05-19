defmodule MMS.NameValue do

  defmacro defcodec as: codec, map: map do
    quote do
      use MMS.Codec
      import MMS.NameValue

      def decode bytes do
        bytes
        |> (unquote codec).decode
        ~> fn {key, rest} ->
             Map.get((unquote map), key)
             ~>> fn _ -> error bytes, :out_of_range end
             ~> fn {name, value_codec} ->
                  rest
                  |> value_codec.decode
                  |> map_value(fn value -> {name, value} end)
                  ~>> fn error -> error bytes, error end
                end
           end
      end

      @encode_map Enum.reduce(unquote(map), %{},
               fn {value, {key, value_codec}}, acc ->
                 Map.put(acc, key, {value, value_codec})
               end)

      def encode {name, value} do
        Map.get(@encode_map, name)
        ~>> fn _ -> error {name, value}, :out_of_range end
        ~> fn {key, codec} ->
             key
             |> (unquote codec).encode
             ~> fn key_bytes ->
                  value
                  |> codec.encode
                  |> map_value(fn value_bytes -> key_bytes <> value_bytes end)
                end
             ~>> fn error -> error {name, value}, error end
           end
      end

      def encode value do
        error value, :out_of_range
      end
    end
  end
end
