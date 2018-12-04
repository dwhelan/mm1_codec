defmodule MM1.Codecs.Extend do
  defmacro __using__(_opts) do
    quote do
      use MM1.Codecs.Base

      def decode bytes do
        decode bytes, __MODULE__
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
