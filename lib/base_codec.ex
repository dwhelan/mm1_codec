defmodule MM1.BaseCodec do
  defmacro __using__(_opts) do
    quote do
      use MM1.BaseDecoder

      def encode %MM1.Result{module: __MODULE__} = result do
        result.bytes
      end
    end
  end
end
