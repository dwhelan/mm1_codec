defmodule MM1.BaseCodec do

  defmacro __using__(opts \\ []) do
    quote bind_quoted: [opts: opts] do
      @wrapped_codex opts[:wrap]

      alias MM1.{Result, Error}

      if @wrapped_codex do
        def decode bytes do
          return %Result{value: @wrapped_codex.decode bytes}
        end
      end

      def decode <<>> do
        return %Error{value: :insufficient_bytes}
      end

      def return %Result{} = result do
        %Result{result | module: __MODULE__}
      end

      def return %Error{} = error do
        %Error{error | module: __MODULE__}
      end
    end
  end
end
