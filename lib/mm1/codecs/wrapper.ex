defmodule MM1.Codecs.Wrapper do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      alias MM1.Result
      @codec       codec

      def decode bytes do
        bytes |> @codec.decode |> wrap_result
      end

      def encode %Result{module: __MODULE__} = result do
        @codec.encode result.value
      end

      def new value do
        value |> @codec.new |> wrap_result
      end

      defp wrap_result result do
        %Result{result | module: __MODULE__, value: result, bytes: <<>>}
      end
    end
  end
end
