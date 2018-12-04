defmodule MM1.Codecs.Extend do
  defmacro __using__(_opts) do
    quote do
      alias MM1.Result

      def decode <<>> do
        %Result{module: __MODULE__, err: :insufficient_bytes}
      end

      def decode bytes do
        decode bytes, __MODULE__
      end

      def new nil do
        %Result{module: __MODULE__, err: :value_cannot_be_nil}
      end

      def new values do
        new values, __MODULE__
      end

      def encode result do
        encode result, __MODULE__
      end
    end
  end
end
