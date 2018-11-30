defmodule MM1.DefaultEncoder do
  defmacro __using__(_opts) do
    quote do
      def encode %MM1.Result{module: __MODULE__} = result do
        result.bytes
      end
    end
  end
end
