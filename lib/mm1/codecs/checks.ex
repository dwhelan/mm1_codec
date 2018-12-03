defmodule MM1.Codecs.Checks do
  defmacro __using__(_opts) do
    quote do
      alias MM1.Result

      def decode <<>>, module do
        %Result{module: module, err: :insufficient_bytes}
      end

      def new nil, module do
        %Result{module: module, err: :value_cannot_be_nil}
      end
    end
  end
end
