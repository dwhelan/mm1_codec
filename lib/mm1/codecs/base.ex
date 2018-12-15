defmodule MM1.Codecs.Base do
  @module_docs """
test
  """
  defmacro __using__(_opts) do
    quote do
      import MMS.DataTypes
      alias MM1.Result
      import Result

      def decode(value) when is_binary(value) == false do
        %Result{module: __MODULE__, err: :must_be_a_binary}
      end

      def decode <<>> do
        %Result{module: __MODULE__, err: :insufficient_bytes}
      end

      def encode nil do
        :value_cannot_be_nil
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
