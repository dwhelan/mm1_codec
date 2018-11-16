defmodule MM1.BaseCodec do

  defmacro __using__(opts \\ []) do
    quote bind_quoted: [opts: opts] do
      @wrapped_codex opts[:wrap]

      alias MM1.Result

      def return %Result{} = result do
        %Result{result | module: __MODULE__}
      end

      if @wrapped_codex do
        def decode bytes do
          return %Result{value: @wrapped_codex.decode bytes}
        end
      else
        def decode <<>> do
          return %Result{value: {:err, :insufficient_bytes}}
        end
      end
    end
  end
end
