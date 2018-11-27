defmodule MM1.Codec do
  defmacro __using__(_opts) do
    quote do
      import MM1.Result

      def decode <<>> do
        error nil, :insufficient_bytes
      end

      def new nil do
        error nil, :value_cannot_be_nil
      end
    end
  end
end
