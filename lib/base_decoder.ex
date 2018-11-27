defmodule MM1.BaseDecoder do
  defmacro __using__(_opts) do
    quote do
      import WAP.Guards
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
