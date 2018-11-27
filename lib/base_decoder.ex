defmodule MM1.BaseDecoder do
  defmacro __using__(_opts) do
    quote do
      import WAP.Guards
      import MM1.Result

      def decode <<>> do
        decode_error :insufficient_bytes, nil, <<>>, <<>>
      end

      def new nil do
        new_error nil, :value_cannot_be_nil
      end
    end
  end
end
