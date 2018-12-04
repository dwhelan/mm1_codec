defmodule MM1.Codecs.Default do
  defmacro __using__(_opts) do
    quote do
      import WAP.Guards
      alias MM1.Result
      import Result

      def decode <<>> do
        %Result{module: __MODULE__, err: :insufficient_bytes}
      end

      def encode result do
        result.bytes
      end

      def new nil do
        %Result{module: __MODULE__, err: :value_cannot_be_nil}
      end
    end
  end
end
