defmodule MM1.WrapperCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      use MM1.BaseDecoder

      @codec codec

      def decode bytes do
        bytes |> @codec.decode |> map_result |> embed
      end

      def encode result do
        result |> unmap_result |> @codec.encode
      end

      def new value do
        value |> @codec.new |> map_result |> embed
      end

      defp map_result result do
        %MM1.Result{result | value: result, bytes: <<>>}
      end

      defp unmap_result result do
        result.value
      end

      defp map_value value do
        value
      end
    end
  end
end
