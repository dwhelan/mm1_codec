defmodule MMS.Lookup do
  use MMS.Codec
  import Codec.Map

  def decode bytes, codec, map do
    bytes |> codec.decode <~> get(map)
  end

  def encode value, codec, unmap do
    value |> get(unmap) ~> codec.encode
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      use MMS.Codec
      import Codec.Map

      @codec   opts[:codec] || MMS.ShortInteger
      @map     opts[:map]   || with_index opts[:values]
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
