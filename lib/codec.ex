defmodule MMS.Codec do
  defmacro default do
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
      import MMS.Codec
      import MMS.DataTypes

    end
  end
end
