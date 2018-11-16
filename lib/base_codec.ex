defmodule MM1.BaseCodec do

  defmacro __using__(opts \\ []) do
    quote do
      alias MM1.Result

      def return %Result{} = result do
        %Result{result | module: __MODULE__}
      end

      def return value, count, bytes do
        {consumed, rest} = String.split_at bytes, count
        %Result{value: value, bytes: consumed, rest: rest, module: __MODULE__}
      end

      def decode <<>> do
        return %Result{value: {:err, :insufficient_bytes}}
      end
    end
  end
end
