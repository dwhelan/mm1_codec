defmodule MMS.Codec do
  defmacro defaults do
    import MMS.OkError

    quote do
      def decode _ do
        error()
      end

      def encode _ do
        error()
      end
    end
  end

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import MMS.OkError
      import MMS.DataTypes

      def decode(value) when is_binary(value) == false do
        error()
      end

      def decode <<>> do
        error()
      end

      import MMS.Codec
    end
  end
end
