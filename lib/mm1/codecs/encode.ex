defmodule MM1.Codecs.Encode do
  defmacro __using__(_opts) do
    quote do
      def encode result do
        result.bytes
      end
    end
  end
end
