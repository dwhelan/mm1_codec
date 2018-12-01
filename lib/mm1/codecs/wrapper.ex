defmodule MM1.Codecs.Wrapper do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      import MM1.Codecs.Decorator
      import MM1.Result
      @codec       codec

      def decode bytes do
        bytes |> @codec.decode |> wrap_result
      end

      def encode %MM1.Result{module: __MODULE__} = result do
        result |> set_module(@codec) |> encode_arg |> @codec.encode
      end

      def new value do
        value |> @codec.new |> wrap_result
      end

      defp wrap_result result do
        %MM1.Result{result | module: __MODULE__, value: result, bytes: <<>>}
      end

      defp encode_arg result do
        result.value
      end
    end
  end
end
