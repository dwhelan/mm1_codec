defmodule MM1.Codecs.Decorator do
  defmacro decorate codec, do: block do
    quote do
      use MM1.Codecs.Base

      @codec unquote codec

      def decode bytes do
        bytes |> @codec.decode |> map_result |> set_module
      end

      def encode %MM1.Result{module: __MODULE__} = result do
        result |> set_module(@codec) |> encode_arg |> @codec.encode
      end

      def new value do
        value |> map_value |> @codec.new |> map_result |> set_module
      end

      unquote block
    end
  end
end
